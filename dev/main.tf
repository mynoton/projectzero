provider "aws" {
  region = "ap-southeast-1"
}

#================================================================
# Create S3 Bucket and DynamoDB
#================================================================

resource "aws_s3_bucket" "terraform_state" {
  bucket = "zero-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "zero-state-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "state_result" {
  value = [
    "${aws_s3_bucket.terraform_state.bucket_domain_name}",
    "${aws_dynamodb_table.terraform_state_lock.arn}"
  ]
}

#================================================================
# Terraform Configuration to Setup State File
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
