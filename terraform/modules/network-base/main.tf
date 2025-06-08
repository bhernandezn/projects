
## VPC ##

resource "aws_vpc" "template_vpc" {
  for_each   = var.vpc_network_values
  cidr_block = each.value.cidr_block

  tags = {
    Name        = each.value.name
    Environment = each.value.name
    Managed-by  = "terraform"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  for_each = {
    for pair in flatten([
      for vpc_key, vpc in var.vpc_network_values : [
        for cidr in vpc.secondary_cidr : {
          vpc_key = vpc_key
          cidr    = cidr
        }
      ] if length(vpc.secondary_cidr) > 0
    ]) : "${pair.vpc_key}-${pair.cidr}" => pair
  }

  vpc_id     = aws_vpc.template_vpc[each.value.vpc_key].id
  cidr_block = each.value.cidr
}

## SUBNET ##

resource "aws_subnet" "template_subnet" {
  for_each          = var.subnet_network_values
  vpc_id            = aws_vpc.template_vpc[each.value.relation_source_vpc_key].id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.selected_az
  tags = merge(each.value.tags,
    {
      Name       = each.value.name_subnet
      Managed-by = "terraform"
    }
  )
  depends_on = [aws_vpc.template_vpc]
}

## PUBLIC IP ##

resource "aws_eip" "template_public_ip" {
  for_each = var.eip_values
  domain   = "vpc"
  tags = {
    Name       = each.value.name_public_ip
    Managed-by = "terraform"
  }
}

## NAT GATEWAY ##

resource "aws_nat_gateway" "template_nat_gateway" {
  for_each      = var.nat_gateway_values
  allocation_id = aws_eip.template_public_ip[each.value.relation_source_eip_values_key].id
  subnet_id     = aws_subnet.template_subnet[each.value.relation_source_subnet_key].id
  tags = {
    Name       = each.value.name_nat_gateway
    Managed-by = "terraform"
  }
}

## INTERNET GATEWAY ##

resource "aws_internet_gateway" "template_internet_gateway" {
  for_each = var.internet_gateway_values
  vpc_id   = aws_vpc.template_vpc[each.value.relation_source_vpc_key].id
  tags = {
    Name       = each.value.name
    Managed-by = "terraform"
  }
  depends_on = [aws_vpc.template_vpc, aws_subnet.template_subnet]
}

## ROUTE TABLE ##

resource "aws_route_table" "template_route_table" {
  for_each = var.route_table_values
  vpc_id   = aws_vpc.template_vpc[each.value.relation_source_vpc_key].id
  route {
    cidr_block     = each.value.cidr_block_route
    gateway_id     = length(each.value.relation_source_internet_gateway_key) > 0 ? aws_internet_gateway.template_internet_gateway[each.value.relation_source_internet_gateway_key].id : null
    nat_gateway_id = length(each.value.relation_source_nat_gateway_key) > 0 ? aws_nat_gateway.template_nat_gateway[each.value.relation_source_nat_gateway_key].id : null
  }
  tags = {
    Name       = each.value.name_route_table
    Managed-by = "terraform"
  }
}

## ROUTE TABLE ASSOCIATION ##

resource "aws_route_table_association" "template_route_table_association" {
  for_each = var.subnet_associations

  subnet_id      = aws_subnet.template_subnet[each.value.relation_source_subnet_key].id
  route_table_id = aws_route_table.template_route_table[each.value.relation_source_route_table_key].id
}
