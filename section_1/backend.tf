terraform {
  backend "s3" {
    bucket = "tf-state-learning"
    key = "development/terraform_state.tf"
    region = "us-east-1"
  }
}