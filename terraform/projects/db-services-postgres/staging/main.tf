# Get remote state form that VPC defined
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "compara-devops"
    key    = "terraform/network/network-base/staging/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "subnet_groups" {
  backend = "s3"
  config = {
    bucket = "compara-devops"
    key    = "terraform/rds/subnet-groups/staging/terraform.tfstate"
    region = "us-east-1"
  }
}

locals {

  vpc_id_value_key = {
    "db-staging" = data.terraform_remote_state.network.outputs.vpc_ids["staging"]
  }
  
  subnets_values_key = {
    "db-staging" = data.terraform_remote_state.subnet_groups.outputs.subnet_groups_ids["general-purpose-private-subnet-groups"]
  }
  

  // Iterating through each key and adding the vpc_id and subnet_ids variables with values from the Network_base project outputs
  security_groups = {
    for key, value in var.aws_security_group : key => merge(value, {
      vpc_id = local.vpc_id_value_key[key]
    })
  }
    
  aws_db_instance = {
    for key, value in var.aws_db_instance : key => merge(value, {
      db_subnet_group_name = local.subnets_values_key[key]
    })
  }     
}

module "base_modules" {
  source = "git::ssh://git@github.com/comparaonline/tf-modules.git//rds-postgres?ref=v1.0.0"
  aws_security_group  = local.security_groups
  aws_db_instance     = local.aws_db_instance
  replic_read_rds     = var.replic_read_rds
}