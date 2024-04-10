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


data "aws_availability_zones" "myaz" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
##this will give me a list of data center
#{az1,az2,az3}

resource "aws_instance" "myec2vm" {
  ami                    = data.aws_ami.example.id
  instance_type          = var.instance_type #instance type
  user_data              = file("${path.module}/install.sh")
  vpc_security_group_ids = [aws_security_group.webserver.id]
  ##suppose your instance are identitacl we will use count. 
  ##if in your instance you need some distinct value we cannot use count
  for_each = toset(data.aws_availability_zones.myaz.names)
  ##based on region this for loop will fin all the az but once it got the az it need to list it in to do the listing of the value we use toset 
  availability_zone = each.key
  tags = {
    "Name" = "server${each.value}"
  }
}


