output "db_endpoint" {

  value = aws_db_instance.postgres.endpoint

}

output "db_identifier" {

  value = aws_db_instance.postgres.id

}