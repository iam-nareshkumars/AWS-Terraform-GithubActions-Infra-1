data "aws_ami" "main" {

  most_recent = true
  owners      = ["703671922956"]

  filter {
    name   = "name"
    values = ["AMI_2"]
  }

}

data "aws_route53_zone" "main" {
  name = var.domain
}