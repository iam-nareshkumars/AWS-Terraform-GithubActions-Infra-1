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