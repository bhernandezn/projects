
module "base_modules" {
  source = "git::ssh://git@github.com/comparaonline/tf-modules.git//network-base?ref=v1.0.0"
  
  # Pasa las variables del módulo raíz al módulo
  vpc_network_values    = var.vpc_network_values
  subnet_network_values = var.subnet_network_values
  eip_values            = var.eip_values
  nat_gateway_values    = var.nat_gateway_values
  internet_gateway_values = var.internet_gateway_values
  route_table_values = var.route_table_values
  subnet_associations = var.subnet_associations
}