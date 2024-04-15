resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id 
}
resource "aws_route_table" "public_route_tables" {
  vpc_id = aws_vpc.vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id 
  }
  tags = {
    Name = "$(var.environment)-public-rtb"
  }
}
#the above mentioned will create a internet gw and attach the internet gw directly to the rtb
###once i create the custom rtb i need to associate the same with all my subnet
resource "aws_route_table_association" "this-rt-assoc" {
  ###using this length function i found out what subnet i have
  count = 2
  #i need to do the iteration one by one
  subnet_id = aws_subnet.public_subnet[count.index].id 
  ###finally associate with all the rtb
  route_table_id = aws_route_table.public_route_tables.id  
}
###created an internet gw and attach the same with vpc
