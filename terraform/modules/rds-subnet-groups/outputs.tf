output "subnet_groups_ids" {
  description = "Subnets groups for RDS"
  value = {for key, subnet_groups in aws_db_subnet_group.template_subnet_group : key => subnet_groups.id}
}