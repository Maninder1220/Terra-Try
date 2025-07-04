variable "cloudflare_zone_id" {
   description = "Cloudflare Zone ID for the domain"
   type        = string
}

# Service CDN Name
variable "domain_name" {}

# fnf website doamin | frndsnfamily.com
variable "fnf_domain_name" {}


variable "acm_domain_validation_options" {}

variable "cloudflare_api_token" {
   description = "Cloudflare API token"
   type        = string
   sensitive   = true
}


