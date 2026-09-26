variable "private_subnet_cidrs" {
  type = list(string)

}

variable "security_group_id" {
  type = list(string)
}

variable "alb-target-group" {
  type = string
}