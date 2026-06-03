resource "aws_security_group" "external_alb" {

  name = "external-alb-sg"

  vpc_id = var.vpc_id

  ingress {

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_security_group" "frontend" {

  name = "frontend-sg"

  vpc_id = var.vpc_id

  ingress {

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [
      aws_security_group.external_alb.id
    ]
  }

}

resource "aws_security_group" "internal_alb" {

  name   = "internal-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 8000
    to_port   = 8000
    protocol  = "tcp"

    security_groups = [
      aws_security_group.frontend.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend" {

  name   = "backend-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 8000
    to_port   = 8000
    protocol  = "tcp"

    security_groups = [
      aws_security_group.internal_alb.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds" {

  name   = "rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = [
      aws_security_group.backend.id
    ]
  }
}