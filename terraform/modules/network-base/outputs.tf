output "vpc_ids" {
  description = "IDs of the VPCs"
  value = {
    for key, vpc in aws_vpc.template_vpc : key => vpc.id
  }
}

output "subnet_ids" {
  description = "IDs of the subnets"
  value = {
    for key, subnet in aws_subnet.template_subnet : key => subnet.id
  }
}