locals {
  resource_sg    = aws_security_group.template_aws_security_group_rds
  cluster_aurora = aws_rds_cluster.aurora_template_cluster
}

data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

data "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"
}

resource "aws_security_group" "template_aws_security_group_rds" {
  for_each = var.aws_security_group

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = can(ingress.value.cidr_blocks) ? ingress.value.cidr_blocks : null
      security_groups = can(ingress.value.security_groups_ids) ? ingress.value.security_groups_ids : null
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = each.value.name
    Maneed_by = "terraform"
  }
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_rds_cluster" "aurora_template_cluster" {
  for_each                        = var.aws_aurora_rds_cluster
  cluster_identifier              = each.value.cluster_identifier
  engine                          = each.value.engine
  engine_version                  = each.value.engine_version
  engine_mode                     = each.value.engine_mode
  availability_zones              = each.value.availability_zones
  enable_local_write_forwarding   = true
  master_username                 = each.value.master_username
  master_password                 = random_password.db_password.result
  db_subnet_group_name            = each.value.db_subnet_group_name
  vpc_security_group_ids          = [local.resource_sg[each.key].id]
  port                            = each.value.port
  db_cluster_parameter_group_name = each.value.db_cluster_parameter_group_name
  backup_retention_period         = each.value.backup_retention_period
  preferred_backup_window         = each.value.preferred_backup_window
  preferred_maintenance_window    = each.value.preferred_maintenance_window
  copy_tags_to_snapshot           = each.value.copy_tags_to_snapshot
  skip_final_snapshot             = each.value.skip_final_snapshot
  storage_encrypted               = each.value.storage_encrypted
  kms_key_id                      = data.aws_kms_key.rds.arn
  deletion_protection             = each.value.deletion_protection

  serverlessv2_scaling_configuration {
    min_capacity = each.value.min_capacity
    max_capacity = each.value.max_capacity
  }

  tags = {
    Environment = each.value.environment_tag
    Name        = each.value.cluster_identifier
  }
  depends_on = [local.resource_sg]
}

resource "aws_rds_cluster_instance" "aurora_template_instance" {
  for_each = var.aws_aurora_rds_instance

  identifier                            = "${aws_rds_cluster.aurora_template_cluster[each.key].cluster_identifier}-instance"
  cluster_identifier                    = local.cluster_aurora[each.key].id
  engine                                = local.cluster_aurora[each.key].engine
  engine_version                        = local.cluster_aurora[each.key].engine_version
  instance_class                        = each.value.instance_class
  db_parameter_group_name               = each.value.db_parameter_group_name
  auto_minor_version_upgrade            = each.value.auto_minor_version_upgrade
  promotion_tier                        = each.value.promotion_tier
  performance_insights_enabled          = each.value.performance_insights_enabled
  performance_insights_retention_period = each.value.performance_insights_retention_period
  performance_insights_kms_key_id       = data.aws_kms_key.rds.arn
  monitoring_interval                   = each.value.monitoring_interval
  monitoring_role_arn                   = data.aws_iam_role.rds_monitoring_role.arn


  tags = {
    Environment = each.value.environment_tag
    Maneed_by   = "terraform"
    Name        = "${local.cluster_aurora[each.key].cluster_identifier}-instance"
  }

  depends_on = [local.cluster_aurora]
}
