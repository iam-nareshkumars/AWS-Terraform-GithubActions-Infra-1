variable "environment" {
   default = "qa"
}
variable "project" {
  default = "eternalplace"
}



variable "sg_name" {
   default = {
      sg_web-lb = "web-alb"
      sg_app-lb = "app-lb"


   }
}
variable "sg_description" {
   default = "Default SG description for services needing dynamic description"
}

variable "url" {
   default = "git::https://github.com/Iam-naresh-devops/SG_module.git" 
}


# variable "tools" {
#   default = {
#     vault = {
#       Name          = "vault"
#       instance_type = "t3.small"
#       port_no       = "8200"
#     }
#   }
# }