
resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true

  enable_dns_support = true

  tags = {
    Name = "three-tier-vpc"
  }
}

resource "aws_subnet" "public_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_1_cidr

  availability_zone = var.az1

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_2_cidr

  availability_zone = var.az2

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "app_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.app_subnet_1_cidr

  availability_zone = var.az1

  tags = {
    Name = "app-subnet-1"
  }
}

resource "aws_subnet" "app_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.app_subnet_2_cidr

  availability_zone = var.az2

  tags = {
    Name = "app-subnet-2"
  }
}
resource "aws_subnet" "db_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.db_subnet_1_cidr

  availability_zone = var.az1

  tags = {
    Name = "db-subnet-1"
  }
}

resource "aws_subnet" "db_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.db_subnet_2_cidr

  availability_zone = var.az2

  tags = {
    Name = "db-subnet-2"
  }
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id

  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_1" {

  subnet_id = aws_subnet.public_1.id

  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {

  subnet_id = aws_subnet.public_2.id

  route_table_id = aws_route_table.public.id
}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "three-tier-igw"
  }
}

resource "aws_eip" "nat" {

  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public_1.id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_route_table" "private_app" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat.id

  }

  tags = {
    Name = "private-app-route-table"
  }
}

resource "aws_route_table_association" "app_1" {

  subnet_id = aws_subnet.app_1.id

  route_table_id = aws_route_table.private_app.id
}

resource "aws_route_table_association" "app_2" {

  subnet_id = aws_subnet.app_2.id

  route_table_id = aws_route_table.private_app.id
}

resource "aws_route_table" "private_db" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-db-route-table"
  }
}

resource "aws_route_table_association" "db_2" {

  subnet_id = aws_subnet.db_2.id

  route_table_id = aws_route_table.private_db.id
}