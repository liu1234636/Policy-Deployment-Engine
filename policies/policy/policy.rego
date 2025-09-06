package gcp.firestore

#import future.keywords.contains
import future.keywords.if

# import Terraform value
pitr_enabled := input.variables.pitr_enabled.value
app_engine := input.variables.app_engine.value
concurrency := input.variables.concurrency.value

#default violations := set()
#default violations := {}

# violations contains ["Firestore must enable PITR"] if
violations["Firestore must enable PITR"] if{
#violations[sprintf("Firestore %v must enable PITR", [db.name])] if {
#    db := input.planned_values.root_module.resources[_]
#    db.type == "google_firestore_database"
#    lower(db.type) == "google_firestore_database"
#    db.expressions.point_in_time_recovery_enablement.references[0] == "var.pitr_enabled"
#    db.values.point_in_time_recovery_enabled != true
    pitr_enabled == false
}

#violations contains ["Firestore must disable App Engine"] if
violations["Firestore must disable App Engine"] if{
#violations[sprintf("Firestore %v must disable App Engine", [db.name])] if {
#    db := input.planned_values.root_module.resources[_]
#    db.type == "google_firestore_database"
#    lower(db.type) == "google_firestore_database"
#    db.expressions.app_engine_integration_mode.references[0] == "var.app_engine"
#    db.values.app_engine_integration == true
    app_engine == true
}

#violations contains ["Firestore must use optimistic concurrency"] if
violations["Firestore must use optimistic concurrency"] if{
#violations[sprintf("Firestore %v must use optimistic concurrency", [db.name])] if {
#    db := input.planned_values.root_module.resources[_]
#    db.type == "google_firestore_database"
#    lower(db.type) == "google_firestore_database"
#    db.expressions.concurrency_mode.references[0] != "var.concurrency"
#    db.values.concurrency_mode != "OPTIMISTIC"
    concurrency != "OPTIMISTIC"
}

# True
result := "Congratulations! No violations!" if {
    count(violations) == 0
}

result := violations if {
    count(violations) > 0
}