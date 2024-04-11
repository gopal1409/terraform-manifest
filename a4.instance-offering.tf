data "aws_ec2_instance_type_offering" "my_instance_1" {
  filter {
    name   = "instance-type"
    values = ["t2.micro", "t3.micro", "t3.medium"]
  }

  preferred_instance_types = ["t3.micro", "t2.micro"]
  filter {
    name   = "location"
    values = ["us-east-1a", "us-east-1b"]
  }
  location_type = "availability-zone"
}