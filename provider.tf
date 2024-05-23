terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
  }
  backend "s3" {
    bucket = "shravan-remote-state"
    key    = "provisioners-local"
    region = "us-east-1"
    dynamodb_table = "shravan-locking"
  }
}


# provide authentication here
provider "aws" {
  region = "us-east-1"
}