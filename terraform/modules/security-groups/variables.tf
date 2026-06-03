variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created."
  type        = string
}

variable "public_subnet_1_id" {
  description = "The ID of the first public subnet."
  type        = string
}

variable "public_subnet_2_id" {
  description = "The ID of the second public subnet."
  type        = string
}

