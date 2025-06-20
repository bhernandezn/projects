addons = {
  "eks-pod-identity-agent" = {
    addon_name                            = "eks-pod-identity-agent"
    addon_version                         = "v1.3.4-eksbuild.1"
    service_account_role_arn_resource_key = ""
    configuration_values                  = ""
  }
  "coredns" = {
    addon_name                            = "coredns"
    addon_version                         = "v1.11.4-eksbuild.2"
    service_account_role_arn_resource_key = ""
    configuration_values                  = "configs/coredns-config.tmpl"
  }
  "vpc-cni" = {
    addon_name                            = "vpc-cni"
    addon_version                         = "v1.19.2-eksbuild.1"
    service_account_role_arn_resource_key = "aws-vpc-cni-addon-role"
    configuration_values                  = "configs/vpc-cni-config.tmpl"
  }
  "kube-proxy" = {
    addon_name                            = "kube-proxy"
    addon_version                         = "v1.31.3-eksbuild.2" # v1.31.3-eksbuild.2
    service_account_role_arn_resource_key = ""
    configuration_values                  = ""
  }
  "aws-ebs-csi-driver" = {
    addon_name                            = "aws-ebs-csi-driver"
    addon_version                         = "v1.38.1-eksbuild.2"
    service_account_role_arn_resource_key = "aws-ebs-csi-driver-addon-role"
    configuration_values                  = ""
  }
}
