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

##this is the resource block
resource "aws_instance" "myec2vm" {
  ##once your instance get created i want to store the instance state information
  ##we need to lable the information
  ###inside the resource block we need to define argument in 
  ##key value format
  ami           = "ami-080e1f13689e07408"
  instance_type = "t3.micro"
  tags = {
    "Name" = "Ec2 demo-1"
  }
}
