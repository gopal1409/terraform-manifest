####
/*data "aws_availability_zone" "my_az" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
*/
resource "aws_instance" "ec2demo" {
  ###i need to create multiple instance according to the number of subnet
  count = length(var.subnet_cidr_private) #count got an value of 3 
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  ####now i need to ensure that this three instance will be created in three different data center
   subnet_id = element(aws_subnet.private.*.id,count.index)
   user_data = file("${path.module}/app/app.sh")
   vpc_security_group_ids = [aws_security_group.webserver.id]
   associate_public_ip_address = true 
   tags = {
     Name = "app-server-${count.index + 1}"
   }
}