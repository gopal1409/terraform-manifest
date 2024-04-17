##this is the launch template which will be used to create instance
resource "aws_launch_template" "launch_template" {
  name                                 = "${var.environment}-launc-template"
  image_id                             = data.aws_ami.amzlinux2.id
  key_name                             = "terraform"
  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
  }

  instance_type = var.instance_type
  network_interfaces {
    device_index = 0
    ##when you launch an instance in aws you can attach multiple nic card. 
    ###always this instance will be attached to the first nic card eth0
    ###
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