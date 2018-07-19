#================================================================
# Create S3 Bucket and DynamoDB
#================================================================

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.s3_bucket_name}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "${var.dynamodb_tbl_name}"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
