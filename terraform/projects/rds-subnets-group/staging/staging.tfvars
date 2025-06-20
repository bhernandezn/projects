#create subnets group#
aws_db_subnet_group = {
  "general-purpose-private-subnet-groups" = {
    subnet_group_name = "general-purpose-private-subnet-groups"
  # subnets_ids = [] These values are obtained from the outputs.tf file in the network_base project.
  },
  ## example for to add other subnet groups
  #   "public-subnet-groups" = {
  #     subnet_group_name = "public-subnet-groups"
  #     subnets_ids = [] These values are obtained from the outputs.tf file in the network_base project.
  #  },
}
