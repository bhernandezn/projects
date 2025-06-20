# create vpc
vpc_network_values = {
  "staging" = {
    name           = "staging"
    cidr_block     = "10.100.0.0/16"
    secondary_cidr = []
  }
}

# create subnets
subnet_network_values = {

  ## Public General Purpose ##

  "10.100.96.0/24-public" = {
    name_subnet             = "10.100.96.0/24-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.96.0/24"
    selected_az             = "us-east-1a"
    tags                    = {}
  },
  "10.100.97.0/24-public" = {
    name_subnet             = "10.100.97.0/24-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.97.0/24"
    selected_az             = "us-east-1b"
    tags                    = {}
  },
  "10.100.98.0/24-public" = {
    name_subnet             = "10.100.98.0/24-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.98.0/24"
    selected_az             = "us-east-1c"
    tags                    = {}
  },
  "10.100.99.0/24-public" = {
    name_subnet             = "10.100.99.0/24-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.99.0/24"
    selected_az             = "us-east-1d"
    tags                    = {}
  },
  "10.100.100.0/24-public" = {
    name_subnet             = "10.100.100.0/24-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.100.0/24"
    selected_az             = "us-east-1e"
    tags                    = {}
  },
  "10.100.101.0/24-public" = {
    name_subnet             = "10.100.101.0/24-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.101.0/24"
    selected_az             = "us-east-1f"
    tags                    = {}
  },

  ## Public ALB ##

  "10.100.108.96/28-public" = {
    name_subnet             = "10.100.108.96/28-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.96/28"
    selected_az             = "us-east-1a"
    tags                    = {
      "kubernetes.io/role/elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.112/28-public" = {
    name_subnet             = "10.100.108.112/28-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.112/28"
    selected_az             = "us-east-1b"
    tags                    = {
      "kubernetes.io/role/elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.128/28-public" = {
    name_subnet             = "10.100.108.128/28-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.128/28"
    selected_az             = "us-east-1c"
    tags                    = {
      "kubernetes.io/role/elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.144/28-public" = {
    name_subnet             = "10.100.108.144/28-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.144/28"
    selected_az             = "us-east-1d"
    tags                    = {
      "kubernetes.io/role/elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.160/28-public" = {
    name_subnet             = "10.100.108.160/28-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.160/28"
    selected_az             = "us-east-1e"
    tags                    = {
      "kubernetes.io/role/elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.176/28-public" = {
    name_subnet             = "10.100.108.176/28-public"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.176/28"
    selected_az             = "us-east-1f"
    tags                    = {
      "kubernetes.io/role/elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },

  ################################################

  ## Private Subnet K8s ##

  "10.100.0.0/20-private" = {
    name_subnet             = "10.100.0.0/20-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.0.0/20"
    selected_az             = "us-east-1a"
    tags                    = {}
  },
  "10.100.16.0/20-private" = {
    name_subnet             = "10.100.16.0/20-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.16.0/20"
    selected_az             = "us-east-1b"
    tags                    = {}
  },
  "10.100.32.0/20-private" = {
    name_subnet             = "10.100.32.0/20-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.32.0/20"
    selected_az             = "us-east-1c"
    tags                    = {}
  },
  "10.100.48.0/20-private" = {
    name_subnet             = "10.100.48.0/20-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.48.0/20"
    selected_az             = "us-east-1d"
    tags                    = {}
  },
  "10.100.64.0/20-private" = {
    name_subnet             = "10.100.64.0/20-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.64.0/20"
    selected_az             = "us-east-1e"
    tags                    = {}
  },
  "10.100.80.0/20-private" = {
    name_subnet             = "10.100.80.0/20-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.80.0/20"
    selected_az             = "us-east-1f"
    tags                    = {}
  },

  ## Private Subnet general purpose  ##

  "10.100.102.0/24-private" = {
    name_subnet             = "10.100.102.0/24-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.102.0/24"
    selected_az             = "us-east-1a"
    tags                    = {}
  },
  "10.100.103.0/24-private" = {
    name_subnet             = "10.100.103.0/24-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.103.0/24"
    selected_az             = "us-east-1b"
    tags                    = {}
  },
  "10.100.104.0/24-private" = {
    name_subnet             = "10.100.104.0/24-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.104.0/24"
    selected_az             = "us-east-1c"
    tags                    = {}
  },
  "10.100.105.0/24-private" = {
    name_subnet             = "10.100.105.0/24-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.105.0/24"
    selected_az             = "us-east-1d"
    tags                    = {}
  },
  "10.100.106.0/24-private" = {
    name_subnet             = "10.100.106.0/24-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.106.0/24"
    selected_az             = "us-east-1e"
    tags                    = {}
  },
  "10.100.107.0/24-private" = {
    name_subnet             = "10.100.107.0/24-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.107.0/24"
    selected_az             = "us-east-1f"
    tags                    = {}
  },

  ## Private Subnet ALB  ##

  "10.100.108.0/28-private" = {
    name_subnet             = "10.100.108.0/28-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.0/28"
    selected_az             = "us-east-1a"
    tags                    = {
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.16/28-private" = {
    name_subnet             = "10.100.108.16/28-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.16/28"
    selected_az             = "us-east-1b"
    tags                    = {
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.32/28-private" = {
    name_subnet             = "10.100.108.32/28-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.32/28"
    selected_az             = "us-east-1c"
    tags                    = {
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.48/28-private" = {
    name_subnet             = "10.100.108.48/28-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.48/28"
    selected_az             = "us-east-1d"
    tags                    = {
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.64/28-private" = {
    name_subnet             = "10.100.108.64/28-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.64/28"
    selected_az             = "us-east-1e"
    tags                    = {
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  },
  "10.100.108.80/28-private" = {
    name_subnet             = "10.100.108.80/28-private"
    relation_source_vpc_key = "staging"
    cidr_block              = "10.100.108.80/28"
    selected_az             = "us-east-1f"
    tags                    = {
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/k8s-staging" = "shared"
    }
  }
}

# create public IPs
eip_values = {
  "public-ip-staging" = {
    name_public_ip = "public-ip-staging"
  }
}

# create nat gateways
nat_gateway_values = {
  "ngw-staging" = {
    name_nat_gateway               = "ngw-staging"
    relation_source_eip_values_key = "public-ip-staging"
    relation_source_subnet_key     = "10.100.96.0/24-public"
  }
}

# create internet gateway
internet_gateway_values = {
  "igw-staging" = {
    name                    = "igw-staging"
    relation_source_vpc_key = "staging"
  }
}

# create route table
route_table_values = {
  "rt-public-staging" = {
    name_route_table                     = "rt-public-staging"
    relation_source_vpc_key              = "staging"
    relation_source_internet_gateway_key = "igw-staging"
    relation_source_nat_gateway_key      = ""
    cidr_block_route                     = "0.0.0.0/0"
  }
  "rt-private-staging" = {
    name_route_table                     = "rt-private-staging"
    relation_source_vpc_key              = "staging"
    relation_source_internet_gateway_key = ""
    relation_source_nat_gateway_key      = "ngw-staging"
    cidr_block_route                     = "0.0.0.0/0"
  }
}

# create route table associations
subnet_associations = {

  ## Public General Purpose ##

  "association-10.100.96.0/24" = {
    relation_source_subnet_key      = "10.100.96.0/24-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.97.0/24" = {
    relation_source_subnet_key      = "10.100.97.0/24-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.98.0/24" = {
    relation_source_subnet_key      = "10.100.98.0/24-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.99.0/24" = {
    relation_source_subnet_key      = "10.100.99.0/24-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.100.0/24" = {
    relation_source_subnet_key      = "10.100.100.0/24-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.101.0/24" = {
    relation_source_subnet_key      = "10.100.101.0/24-public"
    relation_source_route_table_key = "rt-public-staging"
  },

  ## Public ALB ##

  "association-10.100.108.96/28" = {
    relation_source_subnet_key      = "10.100.108.96/28-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.108.112/28" = {
    relation_source_subnet_key      = "10.100.108.112/28-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.108.128/28" = {
    relation_source_subnet_key      = "10.100.108.128/28-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.108.144/28" = {
    relation_source_subnet_key      = "10.100.108.144/28-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.108.160/28" = {
    relation_source_subnet_key      = "10.100.108.160/28-public"
    relation_source_route_table_key = "rt-public-staging"
  },
  "association-10.100.108.176/28" = {
    relation_source_subnet_key      = "10.100.108.176/28-public"
    relation_source_route_table_key = "rt-public-staging"
  }

  ################################################

  ## Private Subnet K8s ##

  "association-10.100.0.0/20" = {
    relation_source_subnet_key      = "10.100.0.0/20-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.16.0/20" = {
    relation_source_subnet_key      = "10.100.16.0/20-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.32.0/20" = {
    relation_source_subnet_key      = "10.100.32.0/20-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.48.0/20" = {
    relation_source_subnet_key      = "10.100.48.0/20-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.64.0/20" = {
    relation_source_subnet_key      = "10.100.64.0/20-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.80.0/20" = {
    relation_source_subnet_key      = "10.100.80.0/20-private"
    relation_source_route_table_key = "rt-private-staging"
  }

  ## Private Subnet General Purpose ##

  "association-10.100.102.0/24" = {
    relation_source_subnet_key      = "10.100.102.0/24-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.103.0/24" = {
    relation_source_subnet_key      = "10.100.103.0/24-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.104.0/24" = {
    relation_source_subnet_key      = "10.100.104.0/24-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.105.0/24" = {
    relation_source_subnet_key      = "10.100.105.0/24-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.106.0/24" = {
    relation_source_subnet_key      = "10.100.106.0/24-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.107.0/24" = {
    relation_source_subnet_key      = "10.100.107.0/24-private"
    relation_source_route_table_key = "rt-private-staging"
  },

  ## Private Subnet ALB ##

  "association-10.100.108.0/28" = {
    relation_source_subnet_key      = "10.100.108.0/28-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.108.16/28" = {
    relation_source_subnet_key      = "10.100.108.16/28-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.108.32/28" = {
    relation_source_subnet_key      = "10.100.108.32/28-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.108.48/28" = {
    relation_source_subnet_key      = "10.100.108.48/28-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.108.64/28" = {
    relation_source_subnet_key      = "10.100.108.64/28-private"
    relation_source_route_table_key = "rt-private-staging"
  },
  "association-10.100.108.80/28" = {
    relation_source_subnet_key      = "10.100.108.80/28-private"
    relation_source_route_table_key = "rt-private-staging"
  }
}
