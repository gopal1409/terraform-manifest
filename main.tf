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



##this will give me a list of data center
#{az1,az2,az3}

resource "aws_instance" "myec2vm" {
  ami                    = data.aws_ami.example.id
  instance_type          = var.instance_type #instance type
  user_data              = file("${path.module}/install.sh")
  vpc_security_group_ids = [aws_security_group.webserver.id]
  ##suppose your instance are identitacl we will use count. 
  ##if in your instance you need some distinct value we cannot use count
  for_each = toset(keys({for az, details in data.aws_ec2_instance_type_offerings.my_instace_type: az => details.instance_types if(details.instance_types) !=0}))
  ##based on region this for loop will fin all the az but once it got the az it need to list it in to do the listing of the value we use toset 
  availability_zone = each.key
  tags = {
    "Name" = "server${each.value}"
  }
}


