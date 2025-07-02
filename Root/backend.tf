terraform {
  required_version = ">= 1.12.0"
  backend "s3" {
    bucket = "my-aws-terraform-backend"
    key = "terraform/state_file/fnf-User/terraform.tfstate"
    region = "ap-south-1"
  }
}




# dynamo db state locking
# required version