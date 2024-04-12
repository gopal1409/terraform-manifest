###first we will create teh target group
resource "aws_lb_target_group" "front-lb" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id 
  health_check {
    enabled = true 
    healthy_threshold = 3
    interval = 10 
    matcher = 200 
    path = "/"
    protocol = "HTTP"
    timeout = 3 
    unhealthy_threshold = 2
  }
}

###attach all the instance behind the target group
resource "aws_alb_target_group_attachment" "attach-app-servers" {
  ##count to iterate the number of resource
  count = length(aws_instance.ec2demo)
  target_group_arn = aws_lb_target_group.front-lb.arn
  target_id = element(aws_instance.ec2demo.*.id,count.index)
  port = 80 
}

###first we will create a listener whcih is like a security groupo for your lb
resource "aws_lb_listener" "list-alb" {
  load_balancer_arn = aws_lb.lb-front.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.front-lb.arn 
  }
}

#create the load balancer 
resource "aws_lb" "lb-front" {
  name = "myalb"
  internal = false 
  load_balancer_type = "application"
  security_groups =  [aws_security_group.webserver.id]
  subnets = [for subnet in aws_subnet.private :  subnet.id]
  enable_deletion_protection = false 
}