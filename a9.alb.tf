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
