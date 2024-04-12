locals {
  inbound_ports = [80,443,22]
  #add port 80 as outbound
  outbound_ports = [0]
}
resource "aws_security_group" "allow_http" {
  name        = "webserver"
  description = "security group for webserver"
  ##3put your own vpc id
  vpc_id      = aws_vpc.this.id

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
##we need to do some iteration