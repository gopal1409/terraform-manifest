output "instance_app_service_public_dns" {
  description = "this is the dns of all your instance"
  value = aws_instance.ec2demo.*.public_dns
  #3i want to display some value in my local console 
}

output "instance_app_service_public_ip" {
  description = "this is the ip of all your instance"
  value = aws_instance.ec2demo.*.public_ip
}