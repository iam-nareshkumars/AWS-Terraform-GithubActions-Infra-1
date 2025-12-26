variable "ami" {}
variable "instance_type" {}
variable "Name" {}
variable "zone_id" {}
variable "domain" {}
variable "environment" {}
variable "project" {}
variable "port_no" {}


variable "iam_action" {
  default = []
}

variable "instance_profile" {
   type = string
}