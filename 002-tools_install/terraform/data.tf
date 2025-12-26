data "aws_ami" "main" {

  most_recent = true
  owners      = ["703671922956"]

  filter {
    name   = "name"
    values = ["aws-ssm-v7"]
  }

}

data "aws_route53_zone" "tools" {
  name = var.domain
}