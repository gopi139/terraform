provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "sample" {
  ami           = "ami-0760b951ddb0c20c9"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_sample.id, "sg-0ca6b9c63c67b0dff"]

  tags = {
    Name = "sample"
  }
}

resource "aws_security_group" "allow_sample" {
  name        = "allow_sample"
  description = "Allow sample traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_sample"
  }
}
terraform {
  backend "s3" {
    bucket = "terraform-139"
    key    = "example/sample/terraform.tfstate"
    region = "us-east-1"
  }
}