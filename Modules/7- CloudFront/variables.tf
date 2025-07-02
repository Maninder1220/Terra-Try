

variable "aliases" {
  description = "List of alternate domain names (CNAMEs) to associate with this distribution"
  type        = list(string)
  default     = []
}

variable "fnf_acm_arn" {
  description = "ARN of an ACM certificate in us-east-1 for HTTPS"
  type        = string
}

variable "default_root_object" {
  description = "Default object to serve (e.g. index.html)"
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "CloudFront Price Class (e.g. PriceClass_100, PriceClass_200, PriceClass_All)"
  type        = string
  default     = "PriceClass_200"
}


variable "oai_arn" {}

variable "fnf_s3_static_bucket_name" {}