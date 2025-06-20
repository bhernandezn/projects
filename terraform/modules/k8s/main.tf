#Variables to define resources more explicitly
locals {
  security_groups           = aws_security_group.cluster-sg
  cluster_roles             = aws_iam_role.cluster_roles
  cluster_attachment_policy = aws_iam_role_policy_attachment.cluster_attachment_policy
  control_plane             = aws_eks_cluster.control_plane
  oidc                      = aws_iam_openid_connect_provider.oidc
  addons_roles              = aws_iam_role.addons_role
  addons_attachment_policy  = aws_iam_role_policy_attachment.addons_attachment_policy
  nodes_template            = aws_launch_template.ec2_nodes_template
}

## Security group for the cluster, here we create the security groups that the cluster needs in general.
## For example, both the control plane and nodes need security groups.
resource "aws_security_group" "cluster-sg" {
  for_each    = var.security_groups
  vpc_id      = each.value.vpc_id
  name        = each.value.name
  description = each.value.description

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = can(ingress.value.cidr_blocks) ? ingress.value.cidr_blocks : null
      security_groups = ingress.value.security_groups_ids
      description     = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = each.value.tags
}

## This resource creates the roles for the cluster. Both the control plane and node groups need roles.
## Note the "assume_role_policy" function which indicates the type of relationship (aws) we will use.
## This relationship is taken from a .tmpl file in our project. Could it be .json? Yes, but if we want to inject
## variables from other resources, .json won't work, that's why we use .tmpl. In the "{}" we can inject
## custom values or values from the resources themselves to associate with the relationships.
resource "aws_iam_role" "cluster_roles" {
  for_each           = var.cluster_role
  name               = each.value.name
  assume_role_policy = templatefile(each.value.assume_role_policy, {})
}

## This resource is related to the previous one, here we define the policies that each role will have.
## As shown in its programming, this resource won't be created if the roles aren't created first.
resource "aws_iam_role_policy_attachment" "cluster_attachment_policy" {
  for_each   = var.cluster_role_policy_attachment
  role       = aws_iam_role.cluster_roles[each.value.resource_aws_iam_role_key].name
  policy_arn = each.value.policy_arn
  depends_on = [local.cluster_roles]
}

## This resource creates the "Control Plane" where the security groups and cluster role previously created are related.
## This resource won't be created if the security groups aren't created and the policies aren't attached to the roles,
## to ensure all permissions are in place before creating the "Control Plane".
resource "aws_eks_cluster" "control_plane" {
  name                          = var.control_plane.name
  version                       = var.control_plane.version
  role_arn                      = local.cluster_roles[var.control_plane.resource_aws_iam_role_key].arn
  bootstrap_self_managed_addons = var.control_plane.bootstrap_self_managed_addons

  upgrade_policy {
    support_type = var.control_plane.support_type
  }

  access_config {
    authentication_mode                         = var.control_plane.authentication_mode
    bootstrap_cluster_creator_admin_permissions = var.control_plane.bootstrap_cluster_creator_admin_permissions
  }

  encryption_config {
    provider {
      key_arn = var.control_plane.key_arn
    }
    resources = ["secrets"]
  }

  kubernetes_network_config {
    ip_family         = var.control_plane.ip_family
    service_ipv4_cidr = var.control_plane.service_ipv4_cidr
  }

  vpc_config {
    endpoint_private_access = var.control_plane.endpoint_private_access
    endpoint_public_access  = var.control_plane.endpoint_public_access
    public_access_cidrs     = var.control_plane.public_access_cidrs
    security_group_ids      = [for sg_key in var.control_plane.resource_security_group_ids_key : local.security_groups[sg_key].id]
    subnet_ids              = var.control_plane.subnet_ids
  }
  tags = var.control_plane.tags

  depends_on = [local.security_groups, local.cluster_attachment_policy]
}

## This resource creates an identity provider in IAM to be used in the addon roles.
## It's created after the cluster because it needs the cluster's OIDC to reference the resource.
resource "aws_iam_openid_connect_provider" "oidc" {
  url             = local.control_plane.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]

  tags = {
    Name      = "${local.control_plane.name}-oidc"
    ManagedBy = "terraform"
  }
  depends_on = [local.control_plane]
}

## Resource to create the addon roles. This resource is created because these roles depend on the OIDC ARN and URL.
## assume_role_policy = this value has a 'templatefile' parameter that will look for a .tmpl file to associate the role relationships
## in manifests, to be able to inject values in '{}' type "variables" extractable from the project itself, as .json files can't read variables.
resource "aws_iam_role" "addons_role" {
  for_each = var.addons_role
  name     = each.value.name
  assume_role_policy = templatefile(each.value.assume_role_policy, {
    oidc_provider_arn = local.oidc.arn
    oidc_provider_url = trimprefix(local.oidc.url, "https://") // removes the "https://" prefix
  })
  depends_on = [local.oidc]
}

## Resource to attach policies to roles, everything is in key format.
## For example: for each key in .tfvars we must enter the name of the role key where we will attach them.
## [each.value.resource_aws_iam_role_key] = name of the key of the local.cluster_role resource.
resource "aws_iam_role_policy_attachment" "addons_attachment_policy" {
  for_each   = var.addons_role_policy_attachment
  role       = local.addons_roles[each.value.resource_aws_iam_role_key].name
  policy_arn = each.value.policy_arn
  depends_on = [local.addons_roles]
}

## Resource to create Addons, each Addon has the possibility to include a configuration file to parameterize the Addon,
## and also the possibility to assign it a role, previously created in the previous resources. None of these roles will be deployed
## if the role policies are not attached.
resource "aws_eks_addon" "aws_eks_addon" {
  for_each                 = var.addons
  cluster_name             = local.control_plane.name
  addon_name               = each.value.addon_name
  addon_version            = each.value.addon_version
  configuration_values     = can(templatefile(each.value.configuration_values)) ? templatefile(each.value.configuration_values) : null
  service_account_role_arn = can(local.addons_roles[each.value.service_account_role_arn_resource_key].arn) ? local.addons_roles[each.value.service_account_role_arn_resource_key].arn : null
  depends_on               = [local.addons_attachment_policy]
}

## Resource to create an EC2 instance template. Is it necessary? Yes, because it's the only way to define what type of disk
## the nodes will use (gp2, gp3, etc.). You cannot define a disk type in the resource that creates the nodes. AWS recommends using EC2 templates,
## so in this resource we will define the values that our EC2 instance will have to use when creating the node group.
## As an extra, we're adding the security group that's created by default for the cluster for traffic and access compatibility.
resource "aws_launch_template" "ec2_nodes_template" {
  for_each    = var.nodes_template
  name_prefix = each.value.name_prefix
  key_name    = each.value.key_name

  vpc_security_group_ids = concat(
      [local.control_plane.vpc_config[0].cluster_security_group_id],
      [for sg_key_node in each.value.resource_security_group_ids_key : local.security_groups[sg_key_node].id]
    )

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = each.value.volume_size
      volume_type           = each.value.volume_type
      iops                  = each.value.iops
      throughput            = each.value.throughput
      encrypted             = each.value.encrypted
      delete_on_termination = each.value.delete_on_termination
    }
  }

  tags = each.value.tags
}

## Resource to create node groups
resource "aws_eks_node_group" "node" {
  for_each       = var.node_groups
  version        = each.value.version
  ami_type       = each.value.ami_type
  capacity_type  = each.value.capacity_type
  cluster_name   = local.control_plane.name
  instance_types = each.value.instance_types
  
  launch_template {
    id = aws_launch_template.ec2_nodes_template[each.value.resource_node_template_key].id
    version = aws_launch_template.ec2_nodes_template[each.value.resource_node_template_key].latest_version
  }

  labels = each.value.labels

  node_group_name = each.value.node_group_name
  node_role_arn   = local.cluster_roles[each.value.resource_aws_iam_role_key].arn

  scaling_config {
    desired_size = each.value.scaling_config_desired_size
    max_size     = each.value.scaling_config_max_size
    min_size     = each.value.scaling_config_min_size
  }

  subnet_ids = each.value.subnet_ids

  tags = each.value.tags

  update_config {
    max_unavailable = each.value.update_config_max_unavailable
  }
  depends_on = [ local.addons_attachment_policy ]
}