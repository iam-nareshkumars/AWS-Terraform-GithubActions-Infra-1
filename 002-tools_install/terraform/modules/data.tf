data "aws_ami" "main" {

   most_recent = true
   owners      = ["703671922956"]

   filter {
    name   = "name"
    values = ["aws-ssm-v7"]
  }

}

data "aws_route53_zone" "main" {
    name = var.domain
}

data "aws_ssm_parameter" "vpc_id" {
 # name = "/eternalplace/qa/vpc_id"
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}
