resource "aws_internet_gateway" "inter_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment}-internet-gw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inter_gateway.id
  }
  tags = {
    Name = "${var.environment}-public-rtb"
  }
}

resource "aws_route_table_association" "this-rt-assoc" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}