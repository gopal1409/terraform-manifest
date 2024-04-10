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
  region = var.region
}


# Create a VPC

##this is the resource block
resource "aws_instance" "myec2vm" {
  ami                    = data.aws_ami.example.id
  instance_type          = var.instance_type #instance type
  user_data              = file("${path.module}/install.sh")
  vpc_security_group_ids = [ aws_security_group.webserver.id]
  ##suppose your instance are identitacl we will use count. 
  ##if in your instance you need some distinct value we cannot use count
  count = 2
  tags = {
    "Name" = "Server-${count.index}"
  }
}

