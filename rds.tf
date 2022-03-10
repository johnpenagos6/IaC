resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "db-john"
  db_name              = "johndb"
  username             = "root"
  password             = "7152823pen"
  skip_final_snapshot  = true
}