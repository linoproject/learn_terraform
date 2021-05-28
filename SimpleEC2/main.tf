terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.42"
    }
  }
}



resource "aws_instance" "MyFirstInstance" {
    ami = data.aws_ami.myAMI.id
    instance_type = "t2.micro"
    associate_public_ip_address = true
    tags = {
      "Name" = var.instance_name
    }
    iam_instance_profile = "ssm"
}

