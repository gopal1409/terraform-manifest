##to create a nat gw minimum required is we need to create an elastic ip and attach the same with the nat gw
resource "aws_eip" "elastic_ip" {
  tags = {
    Name = "${var.environment}-elastic-ip"
  }

}