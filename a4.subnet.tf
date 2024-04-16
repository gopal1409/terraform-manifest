resource "aws_subnet" "public_subnet" {
  count             = 2 #whole number 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.environment}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = 2 #whole number 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.environment}-private-subnet"
  }
}
