terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.42"
    }
  }
}

data "aws_caller_identity" "current" {}
  

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Environment = "Terraform"
      Owner = "Lino Telera"
    }
  }
}


# Create a VPC
resource "aws_vpc" "linoproject" {
  cidr_block = "10.1.0.0/16"
  enable_dns_hostnames = true
}


resource "aws_internet_gateway" "mygw" {
    vpc_id = aws_vpc.linoproject.id
    tags = {
      "Name" = "MyGW"
    }
}

resource "aws_route_table" "routeinet" {
    vpc_id = aws_vpc.linoproject.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.mygw.id
    }
  
}

resource "aws_subnet" "primary" {
    vpc_id     = aws_vpc.linoproject.id
    cidr_block = "10.1.1.0/24"

    tags = {
        Name = "PrimarySubnet"
    }
}

resource "aws_subnet" "secondary" {
    vpc_id     = aws_vpc.linoproject.id
    cidr_block = "10.1.2.0/24"

    tags = {
        Name = "SecondarySubnet"
    }
}

resource "aws_route_table_association" "PriamryTable" {
    subnet_id = aws_subnet.primary.id
    route_table_id = aws_route_table.routeinet.id
  
}

resource "aws_route_table_association" "SecondaryTable" {
    subnet_id = aws_subnet.secondary.id
    route_table_id = aws_route_table.routeinet.id

}