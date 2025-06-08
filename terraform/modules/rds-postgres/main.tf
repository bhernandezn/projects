locals {
  resource_sg           = aws_security_group.template_aws_security_group_rds
  resource_db           = aws_db_instance.template_rds
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

resource "aws_db_instance" "template_rds" {
  for_each = var.aws_db_instance

  # engine identify
  identifier                 = each.value.name
  engine                     = each.value.engine
  engine_version             = each.value.engine_version
  engine_lifecycle_support   = each.value.engine_lifecycle_support
  auto_minor_version_upgrade = each.value.auto_minor_version_upgrade
  parameter_group_name       = each.value.parameter_group_name

  # resource and capacity
  instance_class        = each.value.instance_class
  allocated_storage     = each.value.allocated_storage
  max_allocated_storage = each.value.max_allocated_storage
  iops                  = each.value.iops
  storage_throughput    = each.value.storage_throughput

  # storage setting
  storage_type      = each.value.storage_type
  storage_encrypted = each.value.storage_encrypted
  kms_key_id        = data.aws_kms_key.rds.arn
  snapshot_identifier = each.value.snapshot_identifier_arn

  # access and credentials
  username = each.value.username
  password = random_password.db_password.result
  port     = each.value.port

  # network setting
  db_subnet_group_name   = each.value.db_subnet_group_name
  vpc_security_group_ids = [local.resource_sg[each.key].id]
  publicly_accessible    = each.value.multi_az

  # high availability
  multi_az = each.value.multi_az

  # bakcup and restored
  backup_retention_period = each.value.backup_retention_period
  backup_window           = each.value.backup_window
  backup_target           = each.value.backup_target
  copy_tags_to_snapshot   = each.value.copy_tags_to_snapshot

  # maintenance
  maintenance_window = each.value.maintenance_window
  apply_immediately  = each.value.apply_immediately

  # monitoring and performance
  monitoring_interval                   = each.value.monitoring_interval
  monitoring_role_arn                   = each.value.monitoring_interval > 0 ? data.aws_iam_role.rds_monitoring_role.arn : null
  performance_insights_enabled          = each.value.performance_insights_enabled
  performance_insights_retention_period = each.value.performance_insights_retention_period
  performance_insights_kms_key_id       = data.aws_kms_key.rds.arn

  # protection and delete
  deletion_protection       = each.value.deletion_protection
  skip_final_snapshot       = each.value.skip_final_snapshot
  final_snapshot_identifier = "${each.value.name}-final-snapshot-by-terraform"

  # Tags
  tags = {
    Name            = each.value.name
    Environment_tag = each.value.environment_tag
    Maneged_by      = "terraform"
  }
  depends_on = [random_password.db_password]
}


resource "aws_db_instance" "template_read_replica" {
  for_each = {
    for k, v in var.replic_read_rds : k => v
    if v.create_replic == true
  }

  identifier                 = each.value.name
  replicate_source_db        = local.resource_db[each.value.relation_source_db_key].arn
  instance_class             = each.value.instance_class
  engine                     = local.resource_db[each.value.relation_source_db_key].engine
  engine_version             = local.resource_db[each.value.relation_source_db_key].engine_version
  auto_minor_version_upgrade = local.resource_db[each.value.relation_source_db_key].auto_minor_version_upgrade
  parameter_group_name       = local.resource_db[each.value.relation_source_db_key].parameter_group_name

  # storage setting
  storage_type          = local.resource_db[each.value.relation_source_db_key].storage_type
  allocated_storage     = local.resource_db[each.value.relation_source_db_key].allocated_storage
  max_allocated_storage = local.resource_db[each.value.relation_source_db_key].max_allocated_storage
  storage_encrypted     = local.resource_db[each.value.relation_source_db_key].storage_encrypted
  kms_key_id            = data.aws_kms_key.rds.arn


  # network setting
  db_subnet_group_name   = local.resource_db[each.value.relation_source_db_key].db_subnet_group_name
  vpc_security_group_ids = [local.resource_sg[each.value.relation_source_db_key].id]
  publicly_accessible    = local.resource_db[each.value.relation_source_db_key].publicly_accessible
  availability_zone      = each.value.availability_zone

  # bakcup and restored
  backup_retention_period = each.value.backup_retention_period # Típicamente 0 para réplicas de lectura

  # maintenance
  maintenance_window = "sat:06:00-sat:07:00"
  apply_immediately  = true

  # monitoring and performance
  monitoring_interval                   = each.value.monitoring_interval
  monitoring_role_arn                   = each.value.monitoring_interval > 0 ? data.aws_iam_role.rds_monitoring_role.arn : null
  performance_insights_enabled          = each.value.performance_insights_enabled
  performance_insights_retention_period = each.value.performance_insights_retention_period
  performance_insights_kms_key_id       = data.aws_kms_key.rds.arn

  # Protection y deletion
  deletion_protection       = each.value.deletion_protection
  skip_final_snapshot       = each.value.skip_final_snapshot
  final_snapshot_identifier = "${each.value.name}-final-snapshot-by-terraform"

  # Tags
  tags = {
    Name            = each.value.name
    Environment_tag = local.resource_db[each.value.relation_source_db_key].tags.Environment_tag
    Maneged_by      = "terraform"
  }

  # Dependencias
  depends_on = [local.resource_db]
}
