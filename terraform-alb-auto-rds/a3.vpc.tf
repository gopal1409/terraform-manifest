resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
}

data "aws_availability_zones" "available" {
  state = "available"
}