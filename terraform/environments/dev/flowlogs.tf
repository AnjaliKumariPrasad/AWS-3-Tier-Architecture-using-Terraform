resource "aws_cloudwatch_log_group" "flow_logs" {
  name = "/aws/vpc/flowlogs"
}

resource "aws_iam_role" "flow_logs_role" {

  name = "vpc-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "vpc-flow-logs.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "flow_logs_policy" {

  name = "vpc-flow-logs-policy"

  role = aws_iam_role.flow_logs_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}

resource "aws_flow_log" "vpc_flow_log" {

  vpc_id = module.vpc.vpc_id

  traffic_type = "ALL"

  log_destination_type = "cloud-watch-logs"

  log_destination = aws_cloudwatch_log_group.flow_logs.arn

  iam_role_arn = aws_iam_role.flow_logs_role.arn
}