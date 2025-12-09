terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
 }
 
    }
backend "s3" {
   bucket = "aws-infra-terraform-statefile-bucket-001"
   key    = "sg/qa/terraform.tfstate"
   encrypt = true
   use_lockfile = true
}
}

