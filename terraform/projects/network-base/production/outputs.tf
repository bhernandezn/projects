output "vpc_ids" {
  description = "IDs maps createds"
  value       = module.base_modules.vpc_ids
}

output "subnet_ids" {
  description = "IDs subnet createds"
  value       = module.base_modules.subnet_ids
}