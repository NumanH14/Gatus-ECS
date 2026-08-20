output "bucket_name" {
    value = aws_s3_bucket.project-bucket.id
    description = "provides S3 bucket name"
  
}
output "bucket_arn" {
    value = aws_s3_bucket.project-bucket.arn
    description = "provides the ARN of the s3 bucket"
}
output "kms_key_arn" {
    value = aws_kms_key.mykey.arn
    description = "provides the ARN for kms key"
}