# Launch Template and ASG Resources
resource "aws_launch_template" "launch_template" {
  name          = "${var.environment}-launch-template"
  image_id      = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  network_interfaces {
    device_index    = 0
   # associate_public_ip_address = true
    security_groups = [aws_security_group.asg_security_group.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.environment}-asg-ec2"
    }
  }
  user_data = filebase64("${path.module}/app/app.sh")
}