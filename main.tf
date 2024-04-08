# it is for single line comment
/*
*/
#this is multiple line comment
###terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_instance" "myec2vm" {
  ami = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  tags = {
    "Name" =  "Ec2 demo"
  }
}