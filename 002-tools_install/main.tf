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
  depends_on = [aws_route53_record.main]

  connection {
    type     = "ssh"
    user     = var.user
    password = var.password
    host     = aws_instance.main.private_ip
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
