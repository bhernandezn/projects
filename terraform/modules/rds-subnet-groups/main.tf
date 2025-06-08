
resource "aws_db_subnet_group" "template_subnet_group" {
  for_each   = var.aws_db_subnet_group
  name       = each.value.subnet_group_name
  subnet_ids = each.value.subnet_ids

  tags = {
    Name       = each.value.subnet_group_name
    Maneged_by = "terraform"
  }
}