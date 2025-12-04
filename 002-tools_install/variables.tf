variable "domain" {
  default = "eternallearnings.shop"
}

variable "tools" {
  default = {
    vault = {
      Name          = "vault"
      instance_type = "t3.small"
      port_no       = "8200"
    }

    # jenkins = {
    #   Name          = "jenkins"
    #   instance_type = "t3.medium"
    #   port_no       = "8080"
    # }

    prometheus = {
      Name          = "prometheus"
      instance_type = "t3.small"
      port_no       = "9090"
    }
    grafana = {
      Name          = "grafana"
      instance_type = "t3.micro"
      port_no       = "3000"
    }

  }

}