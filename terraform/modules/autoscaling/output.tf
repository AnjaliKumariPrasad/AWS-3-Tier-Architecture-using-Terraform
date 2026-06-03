output "frontend_asg_name" {

  value = aws_autoscaling_group.frontend.name

}

output "backend_asg_name" {

  value = aws_autoscaling_group.backend.name

}