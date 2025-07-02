output "fnf_s3_static_bucket_name" {
  value = aws_s3_bucket.fnf_static_bucket.bucket
}

output "fnf_static_bucket_arn" {
  value = aws_s3_bucket.fnf_static_bucket.arn
}

output "fnf_static_bucket_id" {
  value = aws_s3_bucket.fnf_static_bucket.id
}