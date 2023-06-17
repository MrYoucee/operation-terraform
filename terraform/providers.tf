# Define provider configuration for AWS
provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "terraform-state-789"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}