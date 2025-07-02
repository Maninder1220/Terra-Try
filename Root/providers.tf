terraform {
  required_version = ">= 1.12.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.6"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.6"
    }
  }
}


provider "aws" {
  region = var.region
}

provider "cloudflare" {
  alias = "cf"
  api_token = var.cloudflare_api_token 
}

provider "github" {
  alias = "gh"
  token = var.github_token
  owner = var.github_owner
}