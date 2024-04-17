resource "aws_db_subnet_group" "dbsubnet" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]

  tags = {
    Name = "My DB subnet group"
  }
}