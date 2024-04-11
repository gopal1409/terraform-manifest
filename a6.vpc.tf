##this is vpc cidr
resource "aws_vpc" "this" {
  cidr_block = var.cidr
  enable_dns_support = true 
  enable_dns_hostnames = true 
  tags = {
    Name = "aap-vpc"
  }
}

#this si subnet will create multiple subnet
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

##we will create an custom route table
resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.this.id 
  tags = {
    Name = "my-app-custom-rtb"
  }
}
##once i create the custom rtb i need to attach my subnet with the custom rtb private subnet
resource "aws_route_table_association" "this-rt-assoc" {
   ##i need to attach all the subnet we will use the count
   count = length(var.subnet_cidr_private)
   ##now i need to attach all my subnet one by one with the route table
   ##we already have all the subnet available
   #element is used to call the existing resource where as for_each will be the creator
   subnet_id = element(aws_subnet.private.*.id,count.index)
   #finally attach 
   route_table_id = aws_route_table.this-rt.id 
}

###lets add the internet gw
resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.this.id 
}

##attach this ig to the route table 
resource "aws_route" "internet_route" {
    #any where in the world
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.this-rt.id 
  gateway_id = aws_internet_gateway.this-igw.id 
}