data "aws_availability_zones" "myaz" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

##check if the respective instance is available in a particular data center
data "aws_ec2_instance_type_offerings" "my_instace_type" {
    ##this for each loop will get all the data center
for_each = toset(data.aws_availability_zones.myaz.names)

filter {
  name = "instance-type"
  values = ["t3.micro"]
}

filter {
  name = "location"
  values = [each.key]
}
location_type = "availability-zone"

}

output "output_v3_1" {
  value = keys({for az, details in data.aws_ec2_instance_type_offerings.my_instace_type:
    az => details.instance_types if length(details.instance_types) != 0 })

}