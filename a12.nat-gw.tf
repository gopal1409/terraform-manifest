resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  #natgw required internet connection we need to create the nat gw in public subnet
  subnet_id  = aws_subnet.public_subnet[0].id
  depends_on = [aws_internet_gateway.inter_gateway]
  tags = {
    Name = "${var.environment}-nat-gw"
  }
}

##once we create the nat gw we will create the rtb
resource "aws_route_table" "private_route_tables" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "${var.environment}-nat-gw-route"
  }
}

#this nat gw need to be attached with my privaste subnet
resource "aws_route_table_association" "private-rt-assoc" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_tables.id
}