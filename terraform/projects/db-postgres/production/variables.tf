data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

data "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"
}

variable "aws_security_group" {
  type = map(object({
    name        = string
    description = string
  //vpc_id      = string
    ingress = list(object({
      from_port           = number
      to_port             = number
      protocol            = string
      cidr_blocks         = list(string)
      security_groups_ids = list(string)
    }))
  }))
}

variable "aws_db_instance" {
  type = map(object({
    # Identification and engine
    name                             = string
    engine                           = string
    engine_version                   = string
    parameter_group_name             = string
    instance_class                   = string
    allocated_storage                = number
    max_allocated_storage            = number
    storage_type                     = string
    username                         = string
    port                             = number
    # db_subnet_group_name           = string
    publicly_accessible              = bool
    multi_az                         = bool
    backup_retention_period          = string
    deletion_protection              = bool
    environment_tag                  = string
    iops                             = number
    storage_throughput               = number

    # optional default values
    snapshot_identifier_arn               = optional(string, null)
    engine_lifecycle_support              = optional(string, "open-source-rds-extended-support-disabled")
    auto_minor_version_upgrade            = optional(bool, true)
    storage_encrypted                     = optional(bool, true)
    copy_tags_to_snapshot                 = optional(bool, true)
    backup_window                         = optional(string, "05:00-06:00")
    backup_target                         = optional(string, "region")
    maintenance_window                    = optional(string, "sat:06:00-sat:07:00")
    apply_immediately                     = optional(bool, true)
    monitoring_interval                   = optional(number, 60)
    performance_insights_enabled          = optional(bool, true)
    performance_insights_retention_period = optional(number, 7)
    skip_final_snapshot                   = optional(bool, true)
  }))
}

variable "replic_read_rds" {
  type = map(object({
    name                   = string
    create_replic          = bool
    instance_class         = string
    availability_zone      = string
    relation_source_db_key = string


    backup_retention_period               = optional(string, 0)
    maintenance_window                    = optional(string, "sat:06:00-sat:07:00")
    apply_immediately                     = optional(bool, true)
    monitoring_interval                   = optional(string, 0)
    performance_insights_enabled          = optional(bool, true)
    performance_insights_retention_period = optional(string, 7)
    deletion_protection                   = optional(bool, false)
    skip_final_snapshot                   = optional(bool, true)

  }))
}