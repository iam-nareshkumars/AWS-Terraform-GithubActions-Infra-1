resource "aws_ssm_parameter" "sg_params" {
  for_each = local.sg_ids

  name  = "/${var.project}/${var.environment}/${each.key}_sg_id"
  type  = "String"
  value = each.value
}

#Fetch the Security Group ID from SSM
data "aws_ssm_parameter" "security_group_id" {
  name = "/${var.project}/${var.environment}/vpn_sg_id" # The exact name used in SSM
}


module "base_securitygroup" {
  for_each = local.sg_map
  source = "git::https://github.com/Iam-naresh-devops/SG_module.git"
  environment = var.environment
  project = var.project
  vpc_id = data.aws_vpc.default.id
  sg_name =  each.value.sg_name
  sg_description =  each.value.sg_description
  #ingress
  ingress_rules = each.value.ingress_rules
  
  }


locals {
  sg_ids_test = {
    for k, v in module.base_securitygroup :
    k => v.sg_id
  }
}


/* resource "aws_security_group_rule" "dynamic_rules" {
  for_each = local.sg_rules

  type        = each.value.type
  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol

  security_group_id = module.securitygroup[each.value.target_sg].sg_id

  source_security_group_id = (
    each.value.source_sg != null ?
    module.securitygroup[each.value.source_sg].sg_id :
    null
  )

  cidr_blocks = (
    each.value.cidr_blocks != null ?
    each.value.cidr_blocks :
    null
  )
}
 */









