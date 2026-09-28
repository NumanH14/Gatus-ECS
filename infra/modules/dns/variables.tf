variable "cloudflare_api_token" {
    type = string
    sensitive = true 
}
variable "cloudflare_zone_id" {
    type = string
}

variable "cloudflare_account_id" {
    type = string
}

variable "domain-name" {
    type = string
    default = "@"
}

variable "alb_dns" {
    type = string
}