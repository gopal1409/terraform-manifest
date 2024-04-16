resource "null_resource" "upload_ssh_key" {
  ###to upload the ssh key we need to first i need to login inside the public server which we have created
  ##to do the the login 
  connection {
    type = "ssh" #rdp 
    #where i want to do ssh the instance we created earlier with public ip
    host        = aws_instance.ec2demo.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("key/terraform.pem")
  }
  ###once we make the connection we will use provisioner
  #in provisioner we have file to transfer file from your local machine to inside remote machine

  provisioner "file" {
    source      = "key/terraform.pem"  #the file should exist in your localmachine
    destination = "/tmp/terraform.pem" #the frontend ec2 instance
  }

  #now if you want to execute some script
  # local-exec
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform.pem"
    ]
  }
}