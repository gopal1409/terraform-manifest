###in the particular region find out all the az is allowed to me
data "aws_availability_zones" "my_az" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
###there will be multiple values this is like an list of values. 
#once we get the list of value
resource "aws_instance" "ec2demo" {

  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name      = "terraform"
  ###instance type here
  subnet_id                   = aws_subnet.public_subnet[0].id
  user_data                   = file("${path.module}/app/app2.sh")
  vpc_security_group_ids      = [aws_security_group.asg_security_group.id]
  associate_public_ip_address = true
  tags = {
    Name = "bastion-server"
  }
}
#ate one sg inside that i wantt to add multiple rule
##the above bnlock will create the ec2 instance in aws. 
###once create the refrence to the ec2 instance is stored in terraform.tfstate file. 