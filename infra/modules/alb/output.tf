output "alb-target-arn" {
    value = aws_lb_target_group.alb-target-group.arn
}

output "alb_name" {
    value = aws_lb.alb_lb.dns_name
}