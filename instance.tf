terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.69.0"
    }
  }
}



provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

resource "aws_instance" "instancia" {
  ami           = "ami-083654bd07b5da81d"
  instance_type = "t2.micro"
  security_groups = ["launch-wizard-3"]
  tags = {
    Name = "instance-john"
}
}

