resource "google_firestore_database" "wrong" {
  name                          = "wrong-db"
  location_id                   = "australia-southeast1"
  type                          = "FIRESTORE_NATIVE"
  # lack point_in_time_recovery_enable → default false
  # lack app_engine_integration    → default true()
  # lack concurrency_mode          → default empty
}