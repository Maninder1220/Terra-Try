# S3 Bucket for Static Content
# This module creates an S3 bucket to host static content for a website.
# The bucket is configured with versioning enabled to allow for recovery of previous versions of files.
# The bucket name is provided as a variable, allowing for flexibility in naming.
resource "aws_s3_bucket" "fnf_static_bucket" {
  bucket = var.fnf_s3_static_bucket_name
  
  
  tags = {
    Name        = "StaticSiteBucket"
    Environment = "ProD"  
  }
    
}


# Versioning for the S3 Bucket
# This enables versioning for the S3 bucket, which is useful for static site hosting
# and allows for recovery of previous versions of files.
# It is important to enable versioning to prevent accidental data loss.
resource "aws_s3_bucket_versioning" "static_site_versioning" {
  bucket = aws_s3_bucket.fnf_static_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}