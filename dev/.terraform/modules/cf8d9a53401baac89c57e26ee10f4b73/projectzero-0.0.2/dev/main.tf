#================================================================
# Provider Declaration
#================================================================

provider "aws" {
  region = "ap-southeast-1"
}

#================================================================
# Module Calling - Services for Remote State
#================================================================

module "services" {
  source = "../modules/data-storage"
  s3_bucket_name = "zero-state"
  dynamodb_tbl_name = "zero-state-lock"
}

#================================================================
# Terraform Configuration
#================================================================

terraform {
  backend "s3" {
    encrypt = true
    bucket = "zero-state"
    dynamodb_table = "zero-state-lock"
    region = "ap-southeast-1"
    key = "dev/terraform.tfstate"
  }
}
