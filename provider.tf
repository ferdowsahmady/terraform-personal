## Configure AWS as provider
provider "aws" {
  region = "us-east-1"
  ## Universal tag applied to all resources by default beside custom tags
  default_tags {
    tags = {
      Company = "Ziyotek"
      Class   = "2024"
      Program = "DevOps"
    }
  }
}

## This block is not required, but tells which version of Terraform/AWS should be used to run code
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"

    }
  }
}

## TF Backend configuration for Remote State file in s3
terraform {
  backend "s3" {
    bucket = "ferdows-terraform-state"
    key    = "terraform-state" # TF creates this file in above bucket
    region = "us-east-1"
  }
}

## TF State Lock file is stored in DynamoDB table in real-world. This table must be created first. 
# dynamodb_table = "terraform-lock"   
# encrypt = true                      
#   }
# }
