# Get remote state form that VPC defined
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "compara-devops"
    key    = "terraform/network/network-base/staging/terraform.tfstate"
    region = "us-east-1"
  }
}

locals {
  # Definición de los grupos de subnets
  # Definition of the subnets gorups
  subnet_groups_mapping = {
    "general-purpose-private-subnet-groups" = [
      data.terraform_remote_state.network.outputs.subnet_ids["10.100.102.0/24-private"],
      data.terraform_remote_state.network.outputs.subnet_ids["10.100.103.0/24-private"],
      data.terraform_remote_state.network.outputs.subnet_ids["10.100.104.0/24-private"],
      data.terraform_remote_state.network.outputs.subnet_ids["10.100.105.0/24-private"],
      data.terraform_remote_state.network.outputs.subnet_ids["10.100.106.0/24-private"],
      data.terraform_remote_state.network.outputs.subnet_ids["10.100.107.0/24-private"]
    ],
    
    ## example for to add other subnet groups
    # "public-subnet-groups" = [
    #   data.terraform_remote_state.network.outputs.subnet_ids["10.100.96.0/24-public"],
    #   data.terraform_remote_state.network.outputs.subnet_ids["10.100.97.0/24-public"],
    #   data.terraform_remote_state.network.outputs.subnet_ids["10.100.98.0/24-public"],
    #   data.terraform_remote_state.network.outputs.subnet_ids["10.100.99.0/24-public"],
    #   data.terraform_remote_state.network.outputs.subnet_ids["10.100.100.0/24-public"],
    #   data.terraform_remote_state.network.outputs.subnet_ids["10.100.101.0/24-public"]
    # ]
  }
  
  # Combinar la configuración con los subnet_ids correspondientes
  subnet_groups = {
    for key, value in var.aws_db_subnet_group : key => merge(value, {
      subnet_ids = local.subnet_groups_mapping[key]
    })
  }
}

module "base_modules" {
  source = "git::ssh://git@github.com/comparaonline/tf-modules.git//rds-subnet-groups?ref=v1.0.0"
  # Pasa las variables del módulo raíz al módulo
  aws_db_subnet_group = local.subnet_groups
}