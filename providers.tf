terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = ">=5.4.0, <5.6.2, !=5.6.1"
      version = "5.6.2"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.1.0"
    }
  }
  required_version = "~>1.5.0"
}

provider "aws" {
  region     = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = var.tags
  }
}
