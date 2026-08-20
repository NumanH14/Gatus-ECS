variable "bucket" {
  type = string
  default = "project-bucket"
}

variable "bucket-tag" {

  type = string
 default = "state-bucket"
}

variable "kms-alias" {
 type = string
 default = "alias/my-key"
}
