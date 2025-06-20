security_groups = {
  "control-plane-custom-sg" = {
    name        = "control-plane-custom-sg"
    description = "control-plane-custom-sg"
    vpc_id      = "vpc-085092efbefb826bd"
    ingress = [
      {
        from_port           = 443
        to_port             = 443
        protocol            = "tcp"
        cidr_blocks         = []
        security_groups_ids = ["sg-092489fa0706e1c18"]
        description         = "permit vpn access https trafic, for access to cluster"
      }
    ]
    tags = {
      Name      = "control-plane-custom-sg"
      ManagedBy = "terraform"
    }
  },
  "node-custom-sg" = {
    name        = "node-custom-sg"
    description = "node-custom-sg"
    vpc_id      = "vpc-085092efbefb826bd"
    ingress = [
      {
        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_blocks         = ["10.100.0.0/16"]
        security_groups_ids = []
        description         = "Allow SSH access to managed worker nodes (private, only inside VPC)"
      }
    ]
    tags = {
      Name      = "node-custom-sg"
      ManagedBy = "terraform"
    }
  }
}
