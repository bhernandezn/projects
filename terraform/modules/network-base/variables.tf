## VPC ##

variable "vpc_network_values" {
  type = map(object({
    name           = string
    cidr_block     = string
    secondary_cidr = list(string)
  }))
}

## SUBNET ##

variable "subnet_network_values" {
  type = map(object({
    name_subnet             = string
    relation_source_vpc_key = string
    cidr_block              = string
    selected_az             = string
    tags                    = map(string)
  }))
}

## PUBLIC IP ##

variable "eip_values" {
  type = map(object({
    name_public_ip = string
  }))
}

## NAT GATEWAY ##

variable "nat_gateway_values" {
  type = map(object({
    name_nat_gateway               = string
    relation_source_subnet_key     = string
    relation_source_eip_values_key = string
  }))
}

## INTERNET GATEWAY ##

variable "internet_gateway_values" {
  type = map(object({
    relation_source_vpc_key = string
    name                    = string
  }))
}

## ROUTE TABLE ##

variable "route_table_values" {
  type = map(object({
    name_route_table                     = string
    relation_source_vpc_key              = string
    relation_source_internet_gateway_key = string
    relation_source_nat_gateway_key      = string
    cidr_block_route                     = string
  }))
}

## ROUTE TABLE ASSOCIATION ##

variable "subnet_associations" {
  type = map(object({
    relation_source_subnet_key      = string
    relation_source_route_table_key = string
  }))
}
