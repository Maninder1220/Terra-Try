output "fnf_acm_arn" {
  value = aws_acm_certificate.fnf_certs.arn
}

output "validation_dns" {
  value = aws_acm_certificate.fnf_certs.domain_validation_options
}

output "acm_domain_validation_options" {
  description = "The DNS records you must create to validate the certificate"
  value       = data.aws_acm_certificate.fnf_cert_details.domain_validation_options
}