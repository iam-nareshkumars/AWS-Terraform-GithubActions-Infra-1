resource "aws_instance" "main" {

  instance_market_options {
    market_type = "spot"
    spot_options {
      spot_instance_type             = "persistent"
      instance_interruption_behavior = "stop"

    }
  }

  ami                    = data.aws_ami.main.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]
  iam_instance_profile   = var.Name == "jenkins-tool" ? "arn:aws:iam::703671922956:instance-profile/Role_for_ec2" : aws_iam_instance_profile.main.name

  tags = {
    Name = "${var.Name}-tool"
  }
}

resource "aws_security_group" "main" {

  name        = "${var.Name}-tool-SG"
  description = "terraform tools automations"

  tags = {
    Name = "${var.Name}-tool-SG"
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "custome SG for tools"
    from_port   = var.port_no
    to_port     = var.port_no
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_route53_record" "main" {


  zone_id = data.aws_route53_zone.main.id
  name    = "${var.Name}.${var.domain}"
  type    = "A"
  ttl     = "10"
  records = [aws_instance.main.private_ip]
}

# resource "null_resource" "main" {


#   triggers = {
#     timestamp = timestamp()
#   }
#   depends_on = [aws_route53_record.main]

#   connection {
#     type     = "ssh"
#     user     = var.user
#     password = var.password
#     host     = aws_instance.main.private_ip
#   }

#   provisioner "remote-exec" {

#     inline = [
#       "sleep 10",
#       "pwd",
#       "echo Running playbook"
#       #"ansible-playbook -i vault.eternallearnings.shop  -e toolname=vault /home/ec2-user/tools_setup/tools.yml"
#     ]
#   }

# }


  