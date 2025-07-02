
# The CloudFront distribution itself
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  comment             = "Static site CDN for ${join(", ", var.aliases)}"
  aliases             = var.aliases
  default_root_object = var.default_root_object
  price_class         = var.price_class

  # a) Origin block pointing at your private S3 bucket
  origin {
    origin_id   = "s3-origin"
    domain_name = var.fnf_s3_static_bucket_name

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${var.oai_arn}"
    }
  }

  # b) Default cache behavior: only GET/HEAD, force HTTPS
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-origin"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # c) Optional logging
  dynamic "logging_config" {
    for_each = length(var.fnf_s3_static_bucket_name) > 0 ? [1] : []
    content {
      bucket = var.fnf_s3_static_bucket_name
      prefix = "cloudfront-logs/"
      include_cookies = false
    }
  }

  # d) HTTPS settings
  viewer_certificate {
    acm_certificate_arn      = var.fnf_acm_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  # e) No geo restrictions
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # f) Clean up behavior on destroy
  retain_on_delete = false
}
