module "base_modules" {
  source                         = "git::ssh://git@github.com/comparaonline/tf-modules.git//k8s?ref=v1.0.0"
  security_groups                = var.security_groups
  control_plane                  = var.control_plane
  cluster_role                   = var.cluster_role
  cluster_role_policy_attachment = var.cluster_role_policy_attachment
  addons_role                    = var.addons_role
  addons_role_policy_attachment  = var.addons_role_policy_attachment
  addons                         = var.addons
  nodes_template                 = var.nodes_template
  node_groups                    = var.node_groups
}
