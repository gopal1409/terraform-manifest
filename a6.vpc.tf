resource "aws_vpc" "this" {
  cidr_block = var.cidr
  enable_dns_support = true 
  enable_dns_hostnames = true 
  tags = {
    Name = "aap-vpc"
  }
}

resource "aws_subnet" "private" {
  count = length(var.subnet_cidr_private) #3 ##count required what a numric value
  # ["10.20.20.0/28", "10.20.20.16/28", "10.20.20.32/28"]
  vpc_id = aws_vpc.this.id 
  cidr_block = var.subnet_cidr_private[count.index]
  #using count.index we are doing the iterarion in subnet and az
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "Subnet-${count.index}"
  }
}