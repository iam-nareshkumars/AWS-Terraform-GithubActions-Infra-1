data "aws_ami" "tools" {

  most_recent = true
  owners      = ["703671922956"]

  filter {
    name   = "name"
    values = ["AMI_2"]
  }

}

data "aws_route53_zone" "tools" {
  name = var.domain
}