
resource "aws_instance" "ec2demo" {

  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name      = "terraform"
  ###instance type here
  subnet_id = aws_subnet.public_subnet[0].id
  ##from the list of items if you want to pick a value after the resource block in square bracket []
  user_data                   = file("${path.module}/app/app2.sh")
  vpc_security_group_ids      = [aws_security_group.asg_security_group.id]
  associate_public_ip_address = true
  tags = {
    Name = "Frontend-Server"
  }
}

##by doing this exercise what we are achiveing is that using ssh i can connect to this frontend server