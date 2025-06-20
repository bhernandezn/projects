aws_security_group = {
  "db-staging" = {
    name        = "db-staging-sg"
    description = "test"
#   vpc_id      = "staging" # These values are obtained from the outputs.tf file in the network_base project.
    ingress = [
      {
        from_port           = 5432
        to_port             = 5432
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
        security_groups_ids = []
      },
      {
        from_port           = 9092
        to_port             = 9092
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
        security_groups_ids = []
      },
    ]
  }
}

aws_db_instance = {
  "db-staging" = {
    name                 = "db-staging"
    engine               = "postgres"
    engine_version       = "16.8"
    parameter_group_name = "default.postgres16"

    # Resources and capacity
    instance_class        = "db.t3.micro"
    allocated_storage     = "500"
    max_allocated_storage = "500" // if this value is increased, storage auto scaling will be activated
    iops                  = 12000 // related to the amount of storage, more storage increases the IOPS (validate the minimum value by simulating RDS creation)
    storage_throughput    = 500   // related to the amount of storage, more storage increases the storage throughput (validate the minimum value by simulating RDS creation)

    # Storage configuration
    storage_type = "gp3" // gp3 type requires minimum 30GB of storage

    # Credentials and access
    username = "postgres"
    # password = # this value is created automatically and stored in the state
    port = "5432"

    # Network configuration
    # db_subnet_group_name = "" These values are obtained from the outputs.tf file in the network_base project.
    publicly_accessible              = false

    # High availability
    multi_az = false

    # Backup and recovery
    backup_retention_period = "7"

    # Protection and deletion
    deletion_protection = false

    # Tags
    environment_tag = "staging"

    # Optional (you can omit them to use default values)
    # snapshot_identifier_arn   = "null"
    # engine_lifecycle_support  = "open-source-rds-extended-support-disabled"
    # auto_minor_version_upgrade = true // Automatic updates: AWS will automatically apply minor version updates of the database engine
    # storage_encrypted         = true
    # copy_tags_to_snapshot     = true
    # backup_window             = "05:00-06:00"
    # backup_target             = "region" // Backups are stored in the same AWS region where the database instance is located
    # maintenance_window        = "sat:06:00-sat:07:00"
    # apply_immediately         = true
    # monitoring_interval       = 60 // set to more than 0 to activate it
    # performance_insights_enabled = true
    # performance_insights_retention_period = 7
    # skip_final_snapshot       = true
  }
}

replic_read_rds = {

  # Values like disk and users are inherited from the main instance

  "staging-replic-1" = {
    create_replic          = true
    name                   = "staging-replic-1"
    relation_source_db_key = "db-staging"
    instance_class         = "db.t3.micro"
    availability_zone      = "us-east-1c"

    # Optional (you can omit them to use default values)

    # backup_retention_period               = "0"
    # maintenance_window                    = "sat:06:00-sat:07:00"
    # apply_immediately                     = true
    # monitoring_interval                   = 0 // set to 0 to deactivate it
    # performance_insights_enabled          = true
    # performance_insights_retention_period = 7
    # deletion_protection                   = false
    # skip_final_snapshot                   = true
  }
}
