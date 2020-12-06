terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "interview" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_hostnames  = true
}
