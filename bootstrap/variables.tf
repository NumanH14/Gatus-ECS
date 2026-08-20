variable "bucket" {
  type = string
  default = "numan-statefile"
}

variable "bucket-tag" {

  type = string
 default = "state-bucket"
}

variable "kms-alias" {
 type = string
 default = "alias/my-key"
}

variable "organisation_id" {
  type      = string
  sensitive = true
}

variable "admin_role_arn" {
  type      = string
  sensitive = true
}

variable "key_user" {
  type      = string
  sensitive = true
}