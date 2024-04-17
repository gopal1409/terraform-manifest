resource "aws_autoscaling_group" "autoscaling_group" {
  name     = "${var.environment}-autoscaling-group"
  max_size = 4
  min_size = 2
  #this instance need to be launch while launching we need to ensire that this instance is launch in multiple data center
  vpc_zone_identifier = flatten([aws_subnet.private_subnet.*.id,
  ])
  ###need to attach instance behind target group of alb
  target_group_arns = [
    aws_alb_target_group.target_group.arn,
  ]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}