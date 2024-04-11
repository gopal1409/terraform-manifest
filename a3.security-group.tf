locals {
  inbound_port   = [80, 443, 22]
  outbound_ports = [0]
}

resource "aws_security_group" "webserver" {
  depends_on = [ aws_vpc.this ]
##depends on once the vpc get created then only execute the aws_security_group
  ###it is an pre define value in terraform it is ensuring that this block will not exe3cute till the 
  name        = "webserver"
  description = "security group belong to web servers"
  #when we create sg i need to define the custom vpc id. it will go to default vpc
   vpc_id = aws_vpc.this.id
  dynamic "ingress" {
    for_each = local.inbound_port
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
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  tags = {
    Name = "web-sg"
  }
}