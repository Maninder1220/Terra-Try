output "oai_arn" {
    value = aws_cloudfront_origin_access_identity.origin_access_identity.arn
}