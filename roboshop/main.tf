resource "aws_spot_instance_request" "cheap_worker" {
  count         = length(var.components)
  ami           = data.aws_ami.ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-0ca6b9c63c67b0dff"]

  tags = {
    Name = element(var.components, count.index )
  }
}
data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "^Centos*"
  owners      = ["973714476881"]
}
variable "components" {
  default = ["frontend", "cart", "catalogue", "shipping", "mongodb", "payment", "mysql", "redis", "user", "rabbitmq"]
}

provider "aws" {
  region = "us-east-1"
}