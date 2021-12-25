output "abc" {
  value = "hello\nwelcome"
}

variable "abc1" {
  default = "100"
}
output "abc1" {
  value = "value of abc1 = ${var.abc1}"
}

variable "abc2" {}
output "abc2" {
  value = var.abc2
}

#string data type
variable "sample1" {
  default = "hello world"
}
output "sample1" {
  value = var.sample1
}

#boolean data type
variable "sample2" {
  default = true
}
output "sample2" {
  value = var.sample2
}

#number data type
variable "sample3" {
  default = 555
}
output "sample3" {
  value = var.sample3
}

variable "samplex" {
  default = [
     "hai",
      333,
      false
  ]
}
output "samplex" {
  value = "value 1 = ${var.samplex[0]}, value 2 = ${var.samplex[2]}"
}