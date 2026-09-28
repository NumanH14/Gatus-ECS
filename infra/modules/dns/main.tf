terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_dns_record" "alb_dns_record" {
  zone_id = var.cloudflare_zone_id
  name = var.domain-name
  ttl = 1
  type = "CNAME"
  comment = "Domain verification record"
  content = var.alb_dns
  proxied = true
  } 


