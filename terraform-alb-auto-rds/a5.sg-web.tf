locals {
  inbound_ports      = [80]
  asg_inbound_ports  = [80, 22]
  asg_outbound_ports = [0]
  #add port 80 as outbound
  outbound_ports = [0]
}
resource "aws_security_group" "alb_security_group" {
  name        = "${var.environment}-alb-sg-group"
  description = "security group for alb"
  ##3put your own vpc id
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = local.inbound_ports
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }

  dynamic "egress" {
    for_each = local.outbound_ports
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }


}

##all the instance also required an sg
##we need to do some iteration

resource "aws_security_group" "asg_security_group" {
  name        = "${var.environment}-asg-sg-group"
  description = "security group for asg"
  ##3put your own vpc id
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = local.asg_inbound_ports
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }

  dynamic "egress" {
    for_each = local.asg_outbound_ports
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }


}

##all the instance also required an sg
##we need to do some iteration