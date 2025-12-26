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
  
  subnet_id              = local.subnet_ids[0]
  

  iam_instance_profile = var.instance_profile
  #iam_instance_profile   = var.Name == "jenkins-tool" ? "arn:aws:iam::703671922956:instance-profile/Role_for_ec2" : aws_iam_instance_profile.robo.name

  tags = merge(local.tags, {
    Name = "${var.Name}-Server"
  })
}

resource "aws_security_group" "main" {

  name        = "${var.Name}-${var.environment}-SG"
  description = "terraform tools automations"
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  tags = merge(local.tags,  {
    Name = "${var.Name}-SG"
  })

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



  