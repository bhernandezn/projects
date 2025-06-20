terraform {
  backend "s3" {
    bucket               = "compara-devops"
    workspace_key_prefix = "terraform/network/network-base/production"
    key                  = "terraform.tfstate"
    region               = "us-east-1"
    encrypt              = true
    kms_key_id           = "0a4b77c9-26d9-44d9-831c-dadce7d18076"
  }
}