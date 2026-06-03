resource "aws_db_subnet_group" "main" {

  name = "three-tier-db-subnet-group"

  subnet_ids = [
    var.db_subnet_1_id,
    var.db_subnet_2_id
  ]

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {

  identifier = "three-tier-postgres"

  engine = "postgres"

  engine_version = "16"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  storage_type = "gp3"

  db_name = var.db_name

  username = var.db_username

  password = var.db_password

  publicly_accessible = false

  multi_az = false

  skip_final_snapshot = true

  vpc_security_group_ids = [
    var.db_sg_id
  ]

  db_subnet_group_name = aws_db_subnet_group.main.name
}