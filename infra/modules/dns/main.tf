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

resource "cloudflare_dns_record" "example_dns_record" {
  zone_id = var.cloudflare_api_token
  name = "@"
  ttl = 1
  type = "A"
  comment = "Domain verification record"
  tags = ["owner:dns-team"]
}
