resource "aws_spot_instance_request" "cheap_worker" {
  count                  = length(var.components)
  ami                    = data.aws_ami.ami.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-0ca6b9c63c67b0dff"]
  wait_for_fulfillment   = true
  tags = {
    Name = local.COMP_NAME
  }
}
resource "aws_ec2_tag" "tags" {
  count       = length(var.components)
  resource_id = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id, count.index )
  key         = "Name"
  value       = local.COMP_NAME
}
resource "aws_route53_record" "records" {
  count   = length(var.components)
  zone_id = Z02680521I7258TX51JJ3
  name    = "${element(var.components,count.index)}.roboshop.internal"
  type    = "A"
  ttl     = "300"
  records = [element(aws_spot_instance_request.cheap_worker.*.private_ip, count.index)]
}

resource "null_resource" "ansible" {
  depends_on  = [aws_route53_record.records]
  count       = length(var.components)
  provisioner "remote-exec" {
    connection {
      host = element(aws_spot_instance_request.cheap_worker.*.private_ip, count.index)
      user = "centos"
      password = "DevOps321"
    }
    inline = [
      "yum install python3-pip -y",
      "pip3 install pip --upgrade",
      "pip3 install ansible",
      " ansible-pull -U https://github.com/gopi139/ansible.git roboshop-pull.yml -e COMPONENT=${local.COMP_NAME} -e ENV=dev"
    ]
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

locals {
  COMP_NAME = element(var.components,count.index)
}