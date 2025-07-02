resource "aws_acm_certificate" "fnf_certs" {
  domain_name       = var.fnf_domain_name
  validation_method = "DNS"
  
  lifecycle {
    create_before_destroy = true
  }

  subject_alternative_names = ["wwww.${var.fnf_domain_name}"]
}

# DNS validation record(s) to automatically create the required CNAME(s)
# You need to reference aws_acm_certificate.fnf_certs.domain_validation_options
# and create corresponding DNS records (e.g., using Cloudflare provider).

data "aws_acm_certificate" "fnf_cert_details" {
  domain       = var.fnf_domain_name
  statuses     = ["PENDING_VALIDATION"]
  most_recent  = true
}



resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.fnf_certs.arn
  validation_record_fqdns = [
    for r in cloudflare_record.acm_validation : r.fqdn
  ]
}