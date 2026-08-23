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

resource "aws_subnet" "main" {
  count = 4
  vpc_id     = aws_vpc.main.id
  cidr_block = "${cidrsubnet(var.vpc_cidr_block,8,count.index)}"
  
  tags = {
    Name = "subnet-${count.index + 0}" 
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
    cidr_block = "0.0.0.0.0"
    gateway_id = aws_internet_gateway.gw.id
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
  gateway_id     = aws_internet_gateway.gw.id
  route_table_id = aws_route_table.public-route.id 
}

resource "aws_route_table_association" "private" {
  count = 2
  subnet_id      = aws_subnet.main[count.index + 2].id
  route_table_id = aws_route_table.private-route.id
}