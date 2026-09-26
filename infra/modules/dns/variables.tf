variable "cloudflare_api_token" {
    type = string
    sensitive = true 
}
variable "zone_id" {
    type = string
    default = "248a547dfaf3028232d5b9c698f66b65"
}
