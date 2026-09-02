variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
}
variable "tenancy_default" {
    type = string
    default = "default"
}
variable "public_subnet_cidrs" {
   type = list(string)
   default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_subnet_cidrs" {
    type = list(string)
    default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "availability_zones" {
    type = list(string)
    default = ["eu-west-2a", "eu-west-2b"]
}