terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    null = {
      source = "hashicorp/null"
      #version = "~> 3.0.0"
    }
    backend "s3" {
    #bucket = "mytfstate-gopal"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true 
    #dynamodb_table = "gopal-tfstate"
    
  }

  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}