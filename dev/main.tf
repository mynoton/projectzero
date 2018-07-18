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
  #source = "../modules/data-storage"
  #source = "git::https://github.com/mynoton/projectzero.git//modules/data-storage?ref=master"
  source = "git::https://github.com/mynoton/projectzero.git//modules/data-storage?ref=v0.0.2"
  s3_bucket_id = "terraform_state"
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
