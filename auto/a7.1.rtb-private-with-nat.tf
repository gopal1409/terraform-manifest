##lets create the natgw
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id 
  subnet_id = aws_subnet.public_subnet[0].id 
  depends_on = [ aws_internet_gateway.internet_gateway ]
   tags = {
    Name = "${var.environment}-natgw"
  }
}
###private_rtb
resource "aws_route_table" "private_route_tables" {
  vpc_id = aws_vpc.vpc.id 
  route  {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

 tags = {
    Name = "${var.environment}-nat-rtb"
  }
}
####associate the natgw with private subnet

resource "aws_route_table_association" "private_rt_assoc" {
  count = 2
  subnet_id = aws_subnet.private_subnet[count.index].id 
  route_table_id = aws_route_table.private_route_tables.id
}