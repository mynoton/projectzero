provider "aws" {
  region = "ap-southeast-1"
}

# terraform state file setup
# create an S3 bucket to store the state file in

resource "aws_s3_bucket" "state-storage-s3" {
    bucket = "remote-state-storage-s3"
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
 
    tags {
      Name = "S3 Remote State Store"
    }      
}