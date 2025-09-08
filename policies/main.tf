terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

#offline mode
provider "google" {
  project     = "test-offline"
  region      = "australia-southeast1"
         
}
variable "suffix"        { default = "" }
variable "pitr_enabled"  { default = true }
variable "app_engine"    { default = false }
variable "concurrency"   { default = "OPTIMISTIC" }

resource "google_firestore_database" "test" {
  name                          = "test-${var.suffix}"
  location_id                   = "australia-southeast1"
  type                          = "FIRESTORE_NATIVE"
  point_in_time_recovery_enablement = var.pitr_enabled
  app_engine_integration_mode = var.app_engine
  concurrency_mode              = var.concurrency
}