terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}

data "cloudflare_zone" "this" {
  name = var.public_domain
}

resource "cloudflare_record" "defence" {
  zone_id = data.cloudflare_zone.this.id
  name    = "defence"
  value   = var.public_ip
  type    = "A"
  proxied = false
  allow_overwrite = true
}

resource "cloudflare_record" "defence-wildcard" {
  zone_id = data.cloudflare_zone.this.id
  name    = "*.defence"
  value   = var.public_ip
  type    = "A"
  proxied = false
  allow_overwrite = true
}