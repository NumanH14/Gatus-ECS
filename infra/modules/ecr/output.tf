output "repositry_name" {
    value = var.aws_ecr_repository.id
}
output "lifecycle_policy" {
    value = var.aws_ecr_lifecycle_policy.id
}
