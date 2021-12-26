resource "aws_instance" "sample" {
  ami           = "ami-0760b951ddb0c20c9"
  instance_type = "t3.micro"
  vpc_security_group_ids = [var.SGID]

  tags = {
    Name = "sample-1"
  }
}
variable "SGID" {}