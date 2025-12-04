variable "ami" {}
variable "instance_type" {}
variable "Name" {}
variable "zone_id" {}
variable "domain" {}
variable "port_no" {}
variable "user" {
  default = "ec2-user"
}
variable "password" {
  default = "DevOps321"
}
variable "iam_action" {
  default = []
}

