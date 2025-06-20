data "terraform_remote_state" "subnet_groups" {
  backend = "s3"
  config = {
    bucket = "compara-devops"
    key    = "terraform/rds/subnet-groups/staging/terraform.tfstate"
    region = "us-east-1"
  }
}

locals {
  
  subnets_values_key = {
   "db-staging" = data.terraform_remote_state.subnet_groups.outputs.subnet_groups_ids["general-purpose-private-subnet-groups"]
  }
      
  aws_aurora_rds_cluster = {
    for key, value in var.aws_aurora_rds_cluster : key => merge(value, {
      db_subnet_group_name = local.subnets_values_key[key]
    })
  }     
}

module "base_modules" {
  source = "git::ssh://git@github.com/comparaonline/tf-modules.git//rds-aurora-mysql?ref=v1.0.0"
  aws_security_group  = var.aws_security_group
  aws_aurora_rds_cluster  = local.aws_aurora_rds_cluster
  aws_aurora_rds_instance = var.aws_aurora_rds_instance
}