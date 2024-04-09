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
  ##once your instance get created i want to store the instance state information
  ##we need to lable the information
  ###inside the resource block we need to define argument in 
  ##key value format
  ami = data.aws_ami.amznlinux2.id
  ###i have ami id as fixed
  ##every region has it own ami id. 

  instance_type = var.instance_type #instance type
  user_data = file("${path.module}/install.sh")
  #vpc_security_group
 vpc_security_group_ids =   [ aws_security_group.ssh.id,aws_security_group.web.id]
  tags = {
    "Name" = "Ec2 demo-1"
  }
}
