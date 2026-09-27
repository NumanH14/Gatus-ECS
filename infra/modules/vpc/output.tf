output "vpc_id" {
  value = aws_vpc.main.id 
}
output "vpc_cidr" {
  value = var.vpc_cidr_block 
}
output "public_sub_id" {
  value = aws_subnet.public[*].id
}
output "private_sub_id" {
  value = aws_subnet.private[*].id
}
output "alb_sg" {
  value = aws_security_group.allow_http-https.id 
}
output "ecs_sg" {
  value = aws_security_group.ecs_sg.id 
}
