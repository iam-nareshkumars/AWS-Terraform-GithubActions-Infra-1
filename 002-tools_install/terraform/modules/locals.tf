locals {
  vpc_id     = data.aws_ssm_parameter.vpc_id.value
  subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  

}

locals {
    tags = {
    Name = "${var.Name}-server-${var.environment}"
    Tool = var.Name
    environment = var.environment
    CreatedBy   = "terraform"
    current_date = formatdate("YYYY-MM-DD", timestamp())
  }
}