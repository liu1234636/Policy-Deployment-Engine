resource "google_firestore_database" "correct" {
  name                           = "correct-db"
  location_id                    = "australia-southeast1"
  type                           = "FIRESTORE_NATIVE"
  concurrency_mode               = "OPTIMISTIC"
  app_engine_integration_mode = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
}