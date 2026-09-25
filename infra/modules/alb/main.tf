resource "aws_lb" "alb_lb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_cidrs.id

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

