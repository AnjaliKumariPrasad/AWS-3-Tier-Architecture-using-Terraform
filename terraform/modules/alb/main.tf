resource "aws_lb" "external" {

  name = "external-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    var.external_alb_sg_id
  ]

  subnets = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]

}

resource "aws_lb_target_group" "frontend" {

  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"

  vpc_id = var.vpc_id

  health_check {

    path = "/"

    protocol = "HTTP"

  }
}

resource "aws_lb_target_group" "backend" {

  name     = "backend-tg"
  port     = 8000
  protocol = "HTTP"

  vpc_id = var.vpc_id

  health_check {

    path = "/"

    protocol = "HTTP"

  }
}

resource "aws_lb" "internal" {

  name = "backend-alb"

  internal = true

  load_balancer_type = "application"

  security_groups = [
    var.internal_alb_sg_id
  ]

  subnets = [
    var.app_subnet_1_id,
    var.app_subnet_2_id
  ]
}

resource "aws_lb_listener" "frontend" {

  load_balancer_arn = aws_lb.external.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

resource "aws_lb_listener" "backend" {

  load_balancer_arn = aws_lb.internal.arn

  port = 8000

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.backend.arn
  }
}