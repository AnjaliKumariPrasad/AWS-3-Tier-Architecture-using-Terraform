resource "aws_s3_bucket" "terraform_state" {

  bucket = "anjali-3tier-tf-state"

  tags = {

    Name = "Terraform State"

  }

}