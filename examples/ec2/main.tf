resource "aws_instance" "sample" {
  count         = length(var.name)
  ami           = "ami-0760b951ddb0c20c9"
  instance_type = "t3.micro"
  vpc_security_group_ids = [var.SGID]

  tags = {
    Name = element(var.name, count.index )
  }
}
variable "SGID" {}
variable "name" {}

output "public_ip" {
  value = aws_instance.sample.public_ip
}