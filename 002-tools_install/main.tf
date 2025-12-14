module "tools" {
  for_each      =  var.tools
  source        =  "./modules"
  ami           = data.aws_ami.tools.id
  instance_type = each.value["instance_type"]
  Name          = each.value["Name"]
  zone_id       = data.aws_route53_zone.tools.zone_id
  domain        = var.domain
  port_no       = each.value["port_no"]
 


}

# resource "aws_instance" "my_ec2" {
#   launch_template {
#     id      = "lt-01469ce463faed971"
#     version = "6"
#   }

#   tags = {
#     Name = "MyEC2FromTemplate"
#   }
# }


resource "null_resource" "main" {


  triggers = {
    timestamp = timestamp()
  }
  

  connection {
    type     = "ssh"
    user     = var.user
    password = var.password
    host     = "${each.value["Name"].var.domain}"
  }

  provisioner "remote-exec" {

    inline = [
      "sleep 10",
      "pwd",
      "echo Running playbook"
      #"ansible-playbook -i vault.eternallearnings.shop  -e toolname=vault /home/ec2-user/tools_setup/tools.yml"
    ]
  }

}
