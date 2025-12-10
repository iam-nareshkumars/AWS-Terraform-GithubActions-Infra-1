terraform {
  required_providers {
    aws = {
      alias = ""
      source  = "hashicorp/aws"
      version = "~> 6.0"
 }
 
    }
backend "s3" {
   bucket = "aws-infra-terraform-statefile-bucket-001"
 #  bucket = "aws-infra-terraform-statefile-bucket-mumbai-002"
   key    = "vpc/qa/terraform.tfstate"
   encrypt = true
   use_lockfile = true
}

}
