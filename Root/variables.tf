variable "cloudflare_api_token" {
   description = "Cloudflare API token"
   type        = string
   sensitive   = true
}

variable "region" {
   description = "AWS region to deploy into"
   type        = string
   sensitive   = true
}

variable "fnf_s3_static_bucket_name" {
   type = string
   sensitive = true
}

variable "fnf_domain_name" {}

variable "cloudflare_zone_id" {
   description = "Cloudflare Zone ID for the domain"
   type        = string
   sensitive   = true
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "github_owner" {
   description = "GitHub org or user name"
   type        = string
   sensitive   = true
   
}