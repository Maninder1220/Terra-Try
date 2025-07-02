

resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = var.fnf_static_bucket_id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}


# This Terraform module manages an S3 bucket and its policy for a static website.
# It creates a bucket, sets its properties, and applies a policy to allow public access to the objects.

# Policy Resource
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.fnf_s3_static_bucket_name
  policy = data.aws_iam_policy_document.fnf_static_bucket_policy.json
}


# Policy Document
# This document defines the permissions for the S3 bucket to allow public access to its objects.
# It allows the `s3:GetObject` action for all objects in the bucket.

data "aws_iam_policy_document" "fnf_static_bucket_policy" {
  statement {
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.fnf_static_bucket.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [var.oai_arn]         # Allow OAI ONLY access to the bucket objects
    }
  }
}

