
# S3 Bucket
module "s3_bucket" {
  source = "../Modules/1 - s3Bucket"
  fnf_s3_static_bucket_name = var.fnf_s3_static_bucket_name
  
}

# S3 Bucket Object
module "s3_object" {
  source = "../Modules/2 - S3Object"
  fnf_s3_static_bucket_name = module.s3_bucket.fnf_s3_static_bucket_name
}

# S3 Bucket Policy
module "s3_bucket_policy" {
  source = "../Modules/3 - s3Policy"
  fnf_s3_static_bucket_name = module.s3_bucket.fnf_s3_static_bucket_name
  fnf_static_bucket_id = module.s3_bucket.fnf_static_bucket_id
  oai_arn = module.cloud_front_oai.oai_arn
}

# ACM Certificate
module "acm_certs" {
  source = "../Modules/4 - ACM_Certs"
  fnf_domain_name = var.fnf_domain_name
}

# CloudFront OAI
module "cloud_front_oai" {
  source = "../Modules/5 - CloudFront_OAI"
  fnf_static_bucket_arn = module.s3_bucket.fnf_s3_static_bucket_arn
  fnf_static_bucket_id =  module.s3_bucket.fnf_static_bucket_id
}

# Cloud Flare DNS
module "cloud_flare_dns" {
  source = "../Modules/6 - CloudFlare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  fnf_domain_name = var.fnf_domain_name
  domain_name = var.fnf_domain_name
  acm_domain_validation_options = module.acm_certs.acm_domain_validation_options
}

# Cloud Front
module "cdn" {
  source = "../Modules/7- CloudFront"
  fnf_s3_static_bucket_name = module.s3_bucket.fnf_s3_static_bucket_name
  oai_arn = module.cloud_front_oai.oai_arn
  fnf_acm_arn = module.acm_certs.fnf_acm_arn
}

