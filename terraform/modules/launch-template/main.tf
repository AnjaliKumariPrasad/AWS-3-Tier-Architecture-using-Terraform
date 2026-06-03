data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {

    name = "name"

    values = ["al2023-ami-*-x86_64"]

  }
}

resource "aws_launch_template" "frontend" {

  name_prefix = "frontend-"

  image_id = data.aws_ami.amazon_linux.id

  instance_type = "t3.micro"

  vpc_security_group_ids = [
    var.frontend_sg_id
  ]

  iam_instance_profile {

    name = var.instance_profile_name

  }

  user_data = base64encode(
    local.frontend_user_data
  )
}

resource "aws_launch_template" "backend" {

  name_prefix = "backend-"

  image_id = data.aws_ami.amazon_linux.id

  instance_type = "t3.micro"

  vpc_security_group_ids = [
    var.backend_sg_id
  ]

  iam_instance_profile {

    name = var.instance_profile_name

  }

  user_data = base64encode(
    local.backend_user_data
  )
}

