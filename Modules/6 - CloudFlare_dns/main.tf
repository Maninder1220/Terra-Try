#------------------------------------------------
#  www.example.com → CloudFront
#------------------------------------------------
resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"                            # just the subdomain label
  type    = "CNAME"
  value   = var.domain_name
  ttl     = 3600
  proxied = true                             # route through Cloudflare’s edge
}

#------------------------------------------------
#  example.com → CloudFront (CNAME flattening)
#------------------------------------------------
resource "cloudflare_record" "root" {
  zone_id = var.cloudflare_zone_id
  name    = "@"                              # the root of the zone
  type    = "CNAME"
  value   = var.domain_name
  ttl     = 3600
  proxied = true
}

#------------------------------------------------
#  Create the Cloudflare DNS record
#------------------------------------------------

resource "cloudflare_record" "acm_validation" {
  for_each = {
    for dvo in var.acm_domain_validation_options :
    dvo.domain_name => dvo
  }
  zone_id = var.cloudflare_zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  value   = each.value.resource_record_value
  ttl     = 120
  proxied = false
}



resource "cloudflare_page_rule" "redirect_root_to_www" {
  zone_id  = var.cloudflare_zone_id
  target   = "${var.fnf_domain_name}/*"     # e.g. "example.com/*"
  priority = 1

  actions = {
    forwarding_url = {
      status_code = 301
      # escape the $ so Terraform treats it literally, not as interpolation
      url         = "https://www.${var.fnf_domain_name}/"
    }
  }
}


