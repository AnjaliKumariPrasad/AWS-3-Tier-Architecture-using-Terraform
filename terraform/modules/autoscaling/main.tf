resource "aws_autoscaling_group" "frontend" {

  name = "frontend-asg"

  min_size = 2

  desired_capacity = 2

  max_size = 4

  vpc_zone_identifier = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]

  launch_template {

    id = var.frontend_lt_id

    version = "$Latest"

  }

  target_group_arns = [
    var.frontend_tg_arn
  ]
}

resource "aws_autoscaling_group" "backend" {

  name = "backend-asg"

  min_size = 2

  desired_capacity = 2

  max_size = 4

  vpc_zone_identifier = [
    var.app_subnet_1_id,
    var.app_subnet_2_id
  ]

  launch_template {

    id = var.backend_lt_id

    version = "$Latest"

  }

  target_group_arns = [
    var.backend_tg_arn
  ]
}