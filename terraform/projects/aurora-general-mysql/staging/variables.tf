variable "aws_security_group" {
  type = map(object({
    name        = string
    description = string
    vpc_id      = string
    ingress = list(object({
      from_port           = number
      to_port             = number
      protocol            = string
      cidr_blocks         = list(string)
      security_groups_ids = list(string)
    }))
  }))
}

variable "aws_aurora_rds_cluster" {
  type = map(object({
    cluster_identifier = string
    engine             = string
    engine_version     = string
    engine_mode        = string
    availability_zones = list(string)
    master_username    = string
    port               = number
    db_cluster_parameter_group_name = string
    backup_retention_period         = string
    preferred_backup_window         = string
    preferred_maintenance_window    = string
    copy_tags_to_snapshot           = bool
    storage_encrypted               = bool
    deletion_protection             = bool
    min_capacity                    = number
    max_capacity                    = number
    skip_final_snapshot             = bool
    enable_local_write_forwarding   = bool

    environment_tag = string

  }))
}

variable "aws_aurora_rds_instance" {
  type = map(object({
    instance_class                        = string
    db_parameter_group_name               = string
    auto_minor_version_upgrade            = bool
    promotion_tier                        = number
    deletion_protection                   = bool
    performance_insights_enabled          = bool
    performance_insights_retention_period = number
    monitoring_interval                   = number
    environment_tag                       = string
  }))
}
