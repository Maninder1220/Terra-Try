resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {}

# Attach bucket policy granting OAI read access
data "aws_iam_policy_document" "s3_oai_policy" {
  statement {
    sid       = "AllowCloudFrontServicePrincipal"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${var.fnf_static_bucket_arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "static_site_oai_policy" {
  bucket = var.fnf_static_bucket_id
  policy = data.aws_iam_policy_document.s3_oai_policy.json
}