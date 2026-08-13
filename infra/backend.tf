terraform {
  backend "s3" {
    bucket = "my-bucket"
    key    = "/gatus-ecs/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = "true"
  }
}
