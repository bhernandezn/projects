control_plane = {
  name                                        = "k8s-staging"
  version                                     = "1.31"
  resource_aws_iam_role_key                   = "cluster_role"
  bootstrap_self_managed_addons               = "false"
  support_type                                = "EXTENDED"
  authentication_mode                         = "API_AND_CONFIG_MAP"
  bootstrap_cluster_creator_admin_permissions = true
  ip_family                                   = "ipv4"
  service_ipv4_cidr                           = "172.20.0.0/16"
  endpoint_private_access                     = true
  endpoint_public_access                      = false
  key_arn                                     = "arn:aws:kms:us-east-1:390844769214:key/f9596f19-d5ff-447d-ab4e-1c8af001fa06"
  public_access_cidrs = [
    # "190.114.37.58/32", // my public ip 
    # "44.209.243.161/32" // se tiene que agregar la ip publica del nodo para que este se incluya en cluster sino no peude entrar, pero no creo sea necesario, tiene que haber otroa forma 
  ]
  resource_security_group_ids_key = ["control-plane-custom-sg"] 
  subnet_ids = [
    // privates subnets services / nodos
    "subnet-090e85b96328686db", // 10.100.0.0/20-private
    "subnet-005fa6dfecfc0b985", // 10.100.16.0/20-private
    "subnet-02ed4a322919a0910", // 10.100.32.0/20-private
    "subnet-00bfc778563483da4", // 10.100.48.0/20-private
    "subnet-065282859a333453f",  // 10.100.80.0/20-private
    // ALBs publics subnets /28
    "subnet-0d040df036f14a20b", // 10.100.108.96/28-public
    "subnet-0e555a046fa3ed316", // 10.100.108.112/28-public
    "subnet-0cb3b759106fcc47b", // 10.100.108.176/28-public
    "subnet-06e66471028121165", // 10.100.108.144/28-public
    "subnet-0e183779b5d1a49ae",  // 10.100.108.128/28-public
    // ALBs private subnets /28
    "subnet-0338a0100c3f22867", // 10.100.108.80/28-private
    "subnet-0d56c48b06fcb8669", // 10.100.108.0/28-private
    "subnet-03c7f74963e4e6a5a", // 10.100.108.16/28-private
    "subnet-0f8285a88c2495858", // 10.100.108.48/28-private
    "subnet-0c035049f6d4e1916"  // 10.100.108.32/28-private
  ]
  tags = {
    Name  = "k8s-staging"
    "Environment" = "staging"
    "ManagedBy"   = "terraform"
  }
}


nodes_template = {
  "ec2-template-staging" = {
    name_prefix           = "ec2-template-staging"
    key_name              = "k8s"
    resource_security_group_ids_key = ["node-custom-sg"]
    volume_size           = 50
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    encrypted             = true
    delete_on_termination = true
    tags = {
      "Environment" = "staging"
      "ManagedBy"   = "terraform"
    }
  }
}

node_groups = {
  "m6a-xlarge-staging-ng" = {
    node_group_name                 = "staging-m6a-xlarge-on-demand"
    resource_aws_iam_role_key       = "node_role"
    ami_type                        = "AL2023_x86_64_STANDARD"
    version                         = "1.31"
    resource_node_template_key      = "ec2-template-staging"
    instance_types = [
      "m6a.xlarge",
    ]
    scaling_config_desired_size   = 1
    scaling_config_max_size       = 1
    scaling_config_min_size       = 1
    capacity_type                 = "ON_DEMAND"
    update_config_max_unavailable = 1
    subnet_ids = [
      "subnet-090e85b96328686db",
      "subnet-005fa6dfecfc0b985",
      "subnet-02ed4a322919a0910",
      "subnet-00bfc778563483da4",
      "subnet-065282859a333453f",
    ]
    tags = {
      "Environment" = "staging"
      "ManagedBy"   = "terraform"
    }
    labels = {
      application           = "services"
      nodegroup-type        = "on-demand-instances"
      instance_availability = "ondemand"
      environment           = "staging"  
    }
  }
}
