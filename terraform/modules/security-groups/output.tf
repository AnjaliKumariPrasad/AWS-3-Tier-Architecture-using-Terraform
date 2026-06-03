output "external_alb_sg_id" {
  value = aws_security_group.external_alb.id
}

output "frontend_sg_id" {
  value = aws_security_group.frontend.id
}

output "internal_alb_sg_id" {
  value = aws_security_group.internal_alb.id
}

output "backend_sg_id" {
  value = aws_security_group.backend.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}