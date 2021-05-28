provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Environment = "Terraform"
      Owner = "Lino Telera"
    }
  }
}