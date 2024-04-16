resource "null_resource" "upload_ssh_key" {


  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type = "ssh"
    host = aws_instance.ec2demo.public_ip 
    user = "ec2-user"
    password = ""
    private_key = file("key/terraform.pem")
  }  

 # Copies the app1 folder to /tmp
  provisioner "file" {
    source      = "key/terraform.pem"
    destination = "/tmp/terraform.pem"
  }

# Copies the /tmp/app1 folder to Apache Webserver /var/www/html directory
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform.pem"
    ]
  }
}