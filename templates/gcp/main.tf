# main.tf
variable "firestore_name"   { type = string }
variable "location"      { type = string }
variable "storage_class" { type = string }

resource "policy_firestore" "b" {
  name          = var.firestore_name
  location      = var.location
  storage_class = var.storage_class

  uniform_bucket_level_access = true
  encryption {
    default_kms_key_name = var.kms_key
  }
}