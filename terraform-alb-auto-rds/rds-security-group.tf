locals {
  rdsinbound_ports = [3306]
  ##we are going to create an sql database

  rdsoutbound_ports = [0]
}
resource "aws_security_group" "rds_security_group" {
  name        = "${var.environment}-rds-sg-group"
  description = "security group for rds"
  ##3put your own vpc id
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = local.rdsinbound_ports
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }

  dynamic "egress" {
    for_each = local.rdsoutbound_ports
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }


}
