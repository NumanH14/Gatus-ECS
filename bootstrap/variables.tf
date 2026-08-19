variable "bucket" {
  type = string
  default = "project-bucket"
}

variable "bucket-tag" {

  type = string
 default = "state-bucket"
}

variable "bucket-policy" {
  type = string
  default = file("bucket-policy.json")
}

variable "kms-alias" {
 type = string
 default = "alias/my-key"
}

variable "kms-policy" {
 type = string
 default = file("kmspolicy.json")  
}