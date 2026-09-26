variable "alb_sg" {
    type = string
    description = "security group for ALB"
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = "public cidr subnets for ALB"
    
}
variable "alb_vpc_id" {
    type = string
    description = "vpc id"
}