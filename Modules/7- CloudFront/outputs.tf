// modules/cloudfront/outputs.tf

output "distribution_id" {
  description = "The CloudFront Distribution ID"
  value       = aws_cloudfront_distribution.cdn.id
}

output "domain_name" {
  description = "The CloudFront domain name (e.g. d1234abcdef8.cloudfront.net)"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "hosted_zone_id" {
  description = "The Route 53 hosted zone ID for this distribution (useful for alias records)"
  value       = aws_cloudfront_distribution.cdn.hosted_zone_id
}
