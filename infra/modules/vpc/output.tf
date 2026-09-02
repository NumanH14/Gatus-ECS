output "vpc_id" {
  value = aws_vpc.main.id 
}
output "vpc_cidr" {
  value = var.vpc_cidr_block 
}
output "subnet_id" {
  value = aws_subnet.public[*].id
}
output "igw_id" {
  value = aws_internet_gateway.gw.id
}
output "public_route_table_id" {
  value = aws_route_table.public-route.id
}
output "private_route_table_id" {
  value = aws_route_table.private-route.id
}