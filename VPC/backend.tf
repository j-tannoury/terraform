terraform {
  backend "s3" {
    bucket = "tf-state-learning"
    key = "development/terraform_state_vpc"
    region = "us-east-1"
  }
}