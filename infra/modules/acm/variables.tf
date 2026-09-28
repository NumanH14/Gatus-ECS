variable "domain_name" {
    type = string
    default = "numanhussainprojects.com"
  
}

variable "cloudflare_zone_id" {
    type = string
}

variable "cloudflare_api_token" {
    type = string
    sensitive = true
}