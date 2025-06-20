variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    vpc_id      = string
    tags        = map(string)
    ingress = list(object({
      from_port           = number
      to_port             = number
      protocol            = string
      cidr_blocks         = list(string)
      security_groups_ids = list(string)

      description = string
    }))
  }))
}

variable "cluster_role" {
  type = map(object({
    name               = string
    assume_role_policy = string
  }))
}

variable "cluster_role_policy_attachment" {
  type = map(object({
    resource_aws_iam_role_key = string
    policy_arn                = string
  }))
}

variable "control_plane" {
  type = object({
    name                                        = string
    version                                     = string
    resource_aws_iam_role_key                   = string
    bootstrap_self_managed_addons               = bool
    key_arn                                     = string
    support_type                                = string
    authentication_mode                         = string
    bootstrap_cluster_creator_admin_permissions = bool
    ip_family                                   = string
    service_ipv4_cidr                           = string
    endpoint_private_access                     = bool
    endpoint_public_access                      = bool
    public_access_cidrs                         = list(string)
    resource_security_group_ids_key             = list(string)
    subnet_ids                                  = list(string)
    tags                                        = map(string)
  })
}

variable "addons_role" {
  type = map(object({
    name               = string
    assume_role_policy = string
  }))
}

variable "addons_role_policy_attachment" {
  type = map(object({
    resource_aws_iam_role_key = string
    policy_arn                = string
  }))
}

variable "addons" {
  type = map(object({
    addon_name                            = string
    addon_version                         = string
    service_account_role_arn_resource_key = string
    configuration_values                  = string
  }))
}

variable "nodes_template" {
  type = map(object({
    name_prefix                     = string
    key_name                        = string
    volume_size                     = number
    volume_type                     = string
    iops                            = number
    throughput                      = number
    encrypted                       = bool
    delete_on_termination           = bool
    resource_security_group_ids_key = list(string)
    tags                            = map(string)
  }))
}

variable "node_groups" {
  type = map(object({
    ami_type                      = string
    resource_node_template_key    = string
    capacity_type                 = string
    instance_types                = list(string)
    labels                        = map(string)
    node_group_name               = string
    resource_aws_iam_role_key     = string
    scaling_config_desired_size   = number
    scaling_config_max_size       = number
    scaling_config_min_size       = number
    subnet_ids                    = list(string)
    tags                          = map(string)
    update_config_max_unavailable = number
    version                       = string

  }))
}
