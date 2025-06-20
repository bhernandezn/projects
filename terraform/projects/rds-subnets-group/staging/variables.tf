variable "aws_db_subnet_group" {
  type = map(object({
    subnet_group_name = string
    //subnets_ids = [] These values are obtained from the outputs.tf file in the network_base project.
  }))
}