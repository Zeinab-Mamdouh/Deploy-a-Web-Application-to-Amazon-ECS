terraform {
  backend "s3" {
    bucket = "terraform-project2023"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}