# Cluster Roles
cluster_role = {
  "cluster_role" = {
    name               = "cluster_role"
    assume_role_policy = "relationship/reationship-eks.tmpl"
  },
  "node_role" = {
    name               = "node_role"
    assume_role_policy = "relationship/relationship-nodes.tmpl"
  }
}

cluster_role_policy_attachment = {
  "attachment_1" = {
    resource_aws_iam_role_key = "cluster_role"
    policy_arn                = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  },
  "attachment_2" = {
    resource_aws_iam_role_key = "cluster_role"
    policy_arn                = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  },
  "attachment_3" = {
    resource_aws_iam_role_key = "node_role"
    policy_arn                = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  },
  "attachment_4" = {
    resource_aws_iam_role_key = "node_role"
    policy_arn                = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  },
  "attachment_5" = {
    resource_aws_iam_role_key = "node_role"
    policy_arn                = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  }
}

#Addons Roles
addons_role = {
  "aws-ebs-csi-driver-addon-role" = {
    name               = "aws-ebs-csi-driver-addon-role"
    assume_role_policy = "relationship/realtionship-ebs-csi-driver-addon.tmpl"
  }
  "aws-vpc-cni-addon-role" = {
    name               = "aws-vpc-cni-addon-role"
    assume_role_policy = "relationship/realtionship-vpc-cni-addons.tmpl"
  }
}

addons_role_policy_attachment = {
  "attachment_1" = {
    resource_aws_iam_role_key = "aws-ebs-csi-driver-addon-role"
    policy_arn                = "arn:aws:iam::390844769214:policy/addon-aws-ebs-csi-driver-role"
  }
  "attachment_2" = {
    resource_aws_iam_role_key = "aws-vpc-cni-addon-role"
    policy_arn                = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  }
}
