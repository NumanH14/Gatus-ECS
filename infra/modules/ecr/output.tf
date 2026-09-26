output "repositry_name" {
    value = aws_ecr_repository.ecr_repo
}
output "lifecycle_policy" {
    value = aws_ecr_lifecycle_policy.ecr_lifecycle_policy
}
