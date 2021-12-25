output "abc" {
  value = "hello\nwelcome"
}

variable "abc1" {
  default = "100"
}
output "abc1" {
  value = var.abc1
}