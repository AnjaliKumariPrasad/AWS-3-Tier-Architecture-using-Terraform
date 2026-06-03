terraform {

  backend "s3" {

    bucket = "anjali-3tier-tf-state"

    key = "dev/terraform.tfstate"

    region = "ap-south-1"

    use_lockfile = true

  }

}