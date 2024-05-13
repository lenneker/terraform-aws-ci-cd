terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "lenneker-terraform-bucket"
    key    = "prod-terraform-state"
    region = "us-east-1"
  }
}

