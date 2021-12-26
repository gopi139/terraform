provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-139"
    key    = "example/sample/terraform.tfstate"
    region = "us-east-1"
  }
}

module "ec2" {
  count  = 2
  source = "./ec2"
  SGID   = module.sg.SGID
  name   = "sample-${count.index}"
}

module "sg" {
  source = "./sg"
}