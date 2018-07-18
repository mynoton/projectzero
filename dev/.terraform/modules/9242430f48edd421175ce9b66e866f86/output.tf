#================================================================
# Remote State Provisioning Result
#================================================================

output "state_result" {
  value = [
    "${aws_s3_bucket.terraform_state.bucket_domain_name}",
    "${aws_dynamodb_table.terraform_state_lock.arn}"
  ]
}
