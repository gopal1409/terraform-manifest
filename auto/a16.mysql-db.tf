resource "aws_db_instance" "wpdb" {
  identifier             = "wpdb"
  auto_minor_version_upgrade  = false
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "mysql"
  #name                   = "mydatabase"
  password               = "mypassword"
  username               = "admin"
  engine_version         = "5.7.44"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.dbsubnet.name
  vpc_security_group_ids = ["${aws_security_group.db.id}"]
  # Workaround for Symphony
  
}
