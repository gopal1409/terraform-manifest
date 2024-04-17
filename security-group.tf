/*resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.main.id

  ingress  {
    description = "allow port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress  {
    description = "allow all ip"
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "web" {
  name        = "allow_web"
  description = "Allow web inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.main.id

  ingress  {
    description = "allow port 80"
    from_port = 80
    to_port = 80 
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress  {
    description = "allow all ip"
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}
*/
##locals it is an meta argument
locals {
  inbound_port   = [80, 443, 22]
  outbound_ports = [0]
}

resource "aws_security_group" "webserver" {
  name        = "webserver-tf-${terraform.workspace}"
  description = "security group belong to web servers"

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
}