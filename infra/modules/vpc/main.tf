terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
}

# provider block will be deleted. just here for testing tf plan purposes

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.tenancy_default

  tags = {
    Name = "main"
  }
}

# Creating 4 subnets

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  count = length(var.public_subnet_cidrs)
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  
  tags = {
    Name = "public subnet" 
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  count = length(var.private_subnet_cidrs)
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  
  tags = {
    Name = "private subnet" 
  }
}

# Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}

#public route table

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main.id 

  route {
    gateway_id = aws_internet_gateway.gw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "public-rt"
  }
}

#private route table

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private-rt"
  }
}

# route table association - public & private assoc
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private-route.id
}

# Security groups & rules

resource "aws_security_group" "allow_http-https" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.allow_http-https.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_http-https.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.allow_http-https.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}