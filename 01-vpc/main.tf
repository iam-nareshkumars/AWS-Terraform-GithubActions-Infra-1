module "eternalplace_vpc" {
    source = "git::https://github.com/iam-nareshkumars/terraform-modules.git/terraform-vpc-module"
    cidr_block = var.cidr_block
    public_subnet = var.public_subnet
    private_subnet = var.private_subnet
    db_subnet = var.db_subnet
    environment = var.environment
    project = var.project
    is_vpc_peer_required = "true"
    accepter_peer_id = ""
    
}