# SECURITY GROUPS
aws_security_group = {
  "db-staging" = {
    name        = "db-staging-sg"
    description = "test"
    vpc_id      = "vpc-085092efbefb826bd"
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

# RDS CLUSTER CONFIGURATION
aws_aurora_rds_cluster = {
  "db-staging" = {
    # Basic configuration
    cluster_identifier = "mysql-serverless-v3"
    engine             = "aurora-mysql"
    engine_version     = "8.0.mysql_aurora.3.08.2"
    engine_mode        = "provisioned"
    port               = 3306
    
    # High availability configuration
    availability_zones = ["us-east-1d", "us-east-1e", "us-east-1b"]
    
    # Access configuration
    master_username = "admin"
    
    # Parameter configuration
    db_cluster_parameter_group_name = "default.aurora-mysql8.0"
    
    # Backup and maintenance configuration
    backup_retention_period      = "1"
    preferred_backup_window      = "05:14-05:44"
    preferred_maintenance_window = "wed:04:19-wed:04:49"
    copy_tags_to_snapshot        = true
    skip_final_snapshot          = true
    
    # Security configuration
    storage_encrypted   = true
    deletion_protection = false
    
    # Serverless capacity configuration
    min_capacity = 0.5
    max_capacity = 5.0
    
    # Additional configuration
    enable_local_write_forwarding = true
    environment_tag               = "staging"
  }
}

# RDS CLUSTER INSTANCE CONFIGURATION
aws_aurora_rds_instance = {
  "db-staging" = {
    # Basic configuration
    instance_class          = "db.serverless"
    db_parameter_group_name = "default.aurora-mysql8.0"
    
    # Upgrade and protection configuration
    auto_minor_version_upgrade = true
    deletion_protection        = false
    promotion_tier             = 1
    
    # Monitoring configuration
    performance_insights_enabled          = true
    performance_insights_retention_period = 7
    monitoring_interval                   = 60
    
    # Tags
    environment_tag = "staging"
  }
}