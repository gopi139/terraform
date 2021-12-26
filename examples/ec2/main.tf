resource "aws_instance" "sample" {
  count         = var.env == "PROD" ? 1 :0
  ami           = "ami-0760b951ddb0c20c9"
  instance_type =var.instance_type == "" ? "t3.micro" : var.instance_type
  vpc_security_group_ids = [var.SGID]

  tags = {
    Name = element(var.name, count.index )
  }
}
variable "SGID" {}
variable "name" {}

variable "instance_type" {}
variable "env" {}