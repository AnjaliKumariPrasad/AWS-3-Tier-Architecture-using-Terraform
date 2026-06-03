variable "vpc_cidr" {}

variable "public_subnet_1_cidr" {
  type = string
}
variable "public_subnet_2_cidr" {
  type = string
}

variable "app_subnet_1_cidr" {
  type = string
}
variable "app_subnet_2_cidr" {
  type = string
}

variable "db_subnet_1_cidr" {
  type = string
}
variable "db_subnet_2_cidr" {
  type = string
}

variable "az1" {
  type = string
}
variable "az2" {
  type = string
}