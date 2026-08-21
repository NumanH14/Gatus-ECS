terraform {
  backend "s3" {
    bucket = "numan-statefile"
    key    = "infra/terraform.tfstate"
    region = "eu-west-2"
    use_lockfile = true
  }
}
