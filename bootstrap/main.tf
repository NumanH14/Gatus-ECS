resource "aws_s3_bucket" "project-bucket" {
  bucket = "my-tf-bucket"
  region = "us-east-1"
  
  tags = {
    Name        = "My bucket"
  }
}

