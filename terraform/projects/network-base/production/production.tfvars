# create vpc
vpc_network_values = {
  "production" = {
    name           = "production"
    cidr_block     = "10.0.0.0/16"
    secondary_cidr = []
  }
}

# create subnets
subnet_network_values = {

  ## Public General Purpose ##

  "10.0.96.0/24-public" = {
    name_subnet             = "10.0.96.0/24-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.96.0/24"
    selected_az             = "us-east-1a"
  },
  "10.0.97.0/24-public" = {
    name_subnet             = "10.0.97.0/24-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.97.0/24"
    selected_az             = "us-east-1b"
  },
  "10.0.98.0/24-public" = {
    name_subnet             = "10.0.98.0/24-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.98.0/24"
    selected_az             = "us-east-1c"
  },
  "10.0.99.0/24-public" = {
    name_subnet             = "10.0.99.0/24-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.99.0/24"
    selected_az             = "us-east-1d"
  },
  "10.0.100.0/24-public" = {
    name_subnet             = "10.0.100.0/24-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.100.0/24"
    selected_az             = "us-east-1e"
  },
  "10.0.101.0/24-public" = {
    name_subnet             = "10.0.101.0/24-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.101.0/24"
    selected_az             = "us-east-1f"
  },

  ## Public ALB ##

  "10.0.108.96/28-public" = {
    name_subnet             = "10.0.108.96/28-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.96/28"
    selected_az             = "us-east-1a"
  },
  "10.0.108.112/28-public" = {
    name_subnet             = "10.0.108.112/28-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.112/28"
    selected_az             = "us-east-1b"
  },
  "10.0.108.128/28-public" = {
    name_subnet             = "10.0.108.128/28-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.128/28"
    selected_az             = "us-east-1c"
  },
  "10.0.108.144/28-public" = {
    name_subnet             = "10.0.108.144/28-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.144/28"
    selected_az             = "us-east-1d"
  },
  "10.0.108.160/28-public" = {
    name_subnet             = "10.0.108.160/28-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.160/28"
    selected_az             = "us-east-1e"
  },
  "10.0.108.176/28-public" = {
    name_subnet             = "10.0.108.176/28-public"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.176/28"
    selected_az             = "us-east-1f"
  },

  ################################################

  ## Private Subnet K8s ##

  "10.0.0.0/20-private" = {
    name_subnet             = "10.0.0.0/20-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.0.0/20"
    selected_az             = "us-east-1a"
  },
  "10.0.16.0/20-private" = {
    name_subnet             = "10.0.16.0/20-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.16.0/20"
    selected_az             = "us-east-1b"
  },
  "10.0.32.0/20-private" = {
    name_subnet             = "10.0.32.0/20-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.32.0/20"
    selected_az             = "us-east-1c"
  },
  "10.0.48.0/20-private" = {
    name_subnet             = "10.0.48.0/20-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.48.0/20"
    selected_az             = "us-east-1d"
  },
  "10.0.64.0/20-private" = {
    name_subnet             = "10.0.64.0/20-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.64.0/20"
    selected_az             = "us-east-1e"
  },
  "10.0.80.0/20-private" = {
    name_subnet             = "10.0.80.0/20-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.80.0/20"
    selected_az             = "us-east-1f"
  },

  ## Private Subnet general purpose  ##

  "10.0.102.0/24-private" = {
    name_subnet             = "10.0.102.0/24-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.102.0/24"
    selected_az             = "us-east-1a"
  },
  "10.0.103.0/24-private" = {
    name_subnet             = "10.0.103.0/24-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.103.0/24"
    selected_az             = "us-east-1b"
  },
  "10.0.104.0/24-private" = {
    name_subnet             = "10.0.104.0/24-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.104.0/24"
    selected_az             = "us-east-1c"
  },
  "10.0.105.0/24-private" = {
    name_subnet             = "10.0.105.0/24-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.105.0/24"
    selected_az             = "us-east-1d"
  },
  "10.0.106.0/24-private" = {
    name_subnet             = "10.0.106.0/24-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.106.0/24"
    selected_az             = "us-east-1e"
  },
  "10.0.107.0/24-private" = {
    name_subnet             = "10.0.107.0/24-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.107.0/24"
    selected_az             = "us-east-1f"
  },

  ## Private Subnet ALB  ##

  "10.0.108.0/28-private" = {
    name_subnet             = "10.0.108.0/28-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.0/28"
    selected_az             = "us-east-1a"
  },
  "10.0.108.16/28-private" = {
    name_subnet             = "10.0.108.16/28-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.16/28"
    selected_az             = "us-east-1b"
  },
  "10.0.108.32/28-private" = {
    name_subnet             = "10.0.108.32/28-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.32/28"
    selected_az             = "us-east-1c"
  },
  "10.0.108.48/28-private" = {
    name_subnet             = "10.0.108.48/28-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.48/28"
    selected_az             = "us-east-1d"
  },
  "10.0.108.64/28-private" = {
    name_subnet             = "10.0.108.64/28-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.64/28"
    selected_az             = "us-east-1e"
  },
  "10.0.108.80/28-private" = {
    name_subnet             = "10.0.108.80/28-private"
    relation_source_vpc_key = "production"
    cidr_block              = "10.0.108.80/28"
    selected_az             = "us-east-1f"
  }
}

# create public IPs
eip_values = {
  "public-ip-production" = {
    name_public_ip = "public-ip-production"
  }
}

# create nat gateways
nat_gateway_values = {
  "ngw-production" = {
    name_nat_gateway               = "ngw-production"
    relation_source_eip_values_key = "public-ip-production"
    relation_source_subnet_key     = "10.0.96.0/24-public"
  }
}

# create internet gateway
internet_gateway_values = {
  "igw-production" = {
    name                    = "igw-production"
    relation_source_vpc_key = "production"
  }
}

# create route table
route_table_values = {
  "rt-public-production" = {
    name_route_table                     = "rt-public-production"
    relation_source_vpc_key              = "production"
    relation_source_internet_gateway_key = "igw-production"
    relation_source_nat_gateway_key      = ""
    cidr_block_route                     = "0.0.0.0/0"
  }
  "rt-private-production" = {
    name_route_table                     = "rt-private-production"
    relation_source_vpc_key              = "production"
    relation_source_internet_gateway_key = ""
    relation_source_nat_gateway_key      = "ngw-production"
    cidr_block_route                     = "0.0.0.0/0"
  }
}

# create route table associations
subnet_associations = {

  ## Public General Purpose ##

  "association-10.0.96.0/24" = {
    relation_source_subnet_key      = "10.0.96.0/24-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.97.0/24" = {
    relation_source_subnet_key      = "10.0.97.0/24-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.98.0/24" = {
    relation_source_subnet_key      = "10.0.98.0/24-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.99.0/24" = {
    relation_source_subnet_key      = "10.0.99.0/24-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.100.0/24" = {
    relation_source_subnet_key      = "10.0.100.0/24-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.101.0/24" = {
    relation_source_subnet_key      = "10.0.101.0/24-public"
    relation_source_route_table_key = "rt-public-production"
  },

  ## Public ALB ##

  "association-10.0.108.96/28" = {
    relation_source_subnet_key      = "10.0.108.96/28-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.108.112/28" = {
    relation_source_subnet_key      = "10.0.108.112/28-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.108.128/28" = {
    relation_source_subnet_key      = "10.0.108.128/28-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.108.144/28" = {
    relation_source_subnet_key      = "10.0.108.144/28-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.108.160/28" = {
    relation_source_subnet_key      = "10.0.108.160/28-public"
    relation_source_route_table_key = "rt-public-production"
  },
  "association-10.0.108.176/28" = {
    relation_source_subnet_key      = "10.0.108.176/28-public"
    relation_source_route_table_key = "rt-public-production"
  }

  ################################################

  ## Private Subnet K8s ##

  "association-10.0.0.0/20" = {
    relation_source_subnet_key      = "10.0.0.0/20-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.16.0/20" = {
    relation_source_subnet_key      = "10.0.16.0/20-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.32.0/20" = {
    relation_source_subnet_key      = "10.0.32.0/20-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.48.0/20" = {
    relation_source_subnet_key      = "10.0.48.0/20-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.64.0/20" = {
    relation_source_subnet_key      = "10.0.64.0/20-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.80.0/20" = {
    relation_source_subnet_key      = "10.0.80.0/20-private"
    relation_source_route_table_key = "rt-private-production"
  }

  ## Private Subnet General Purpose ##

  "association-10.0.102.0/24" = {
    relation_source_subnet_key      = "10.0.102.0/24-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.103.0/24" = {
    relation_source_subnet_key      = "10.0.103.0/24-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.104.0/24" = {
    relation_source_subnet_key      = "10.0.104.0/24-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.105.0/24" = {
    relation_source_subnet_key      = "10.0.105.0/24-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.106.0/24" = {
    relation_source_subnet_key      = "10.0.106.0/24-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.107.0/24" = {
    relation_source_subnet_key      = "10.0.107.0/24-private"
    relation_source_route_table_key = "rt-private-production"
  },

  ## Private Subnet ALB ##

  "association-10.0.108.0/28" = {
    relation_source_subnet_key      = "10.0.108.0/28-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.108.16/28" = {
    relation_source_subnet_key      = "10.0.108.16/28-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.108.32/28" = {
    relation_source_subnet_key      = "10.0.108.32/28-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.108.48/28" = {
    relation_source_subnet_key      = "10.0.108.48/28-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.108.64/28" = {
    relation_source_subnet_key      = "10.0.108.64/28-private"
    relation_source_route_table_key = "rt-private-production"
  },
  "association-10.0.108.80/28" = {
    relation_source_subnet_key      = "10.0.108.80/28-private"
    relation_source_route_table_key = "rt-private-production"
  }
}
