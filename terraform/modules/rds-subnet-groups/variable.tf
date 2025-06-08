variable "aws_db_subnet_group" {
  type = map(object({
    subnet_group_name = string
    subnet_ids        = list(string)
  }))
}