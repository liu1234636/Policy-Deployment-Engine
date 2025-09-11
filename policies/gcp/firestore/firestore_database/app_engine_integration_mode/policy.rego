package terraform.gcp.firestore.database.app_engine_integration_mode

import data.terraform.gcp.helpers

default allow = false

# 允许规则：所有 Firestore Database 的 app_engine_integration_mode 必须为 DISABLED
allow {
    some resource
    resources := helpers.get_all_resources("google_firestore_database")
    resource := resources[_]
    resource_values := resource.values
    resource_values.app_engine_integration_mode == "DISABLED"
}

# 违规规则：app_engine_integration_mode 未设置为 DISABLED
violation[res] {
    resources := helpers.get_all_resources("google_firestore_database")
    resource := resources[_]
    resource_values := resource.values
    not resource_values.app_engine_integration_mode == "DISABLED"
    res := {
        "msg": sprintf("Firestore database '%v' 的 app_engine_integration_mode 未设置为 DISABLED，而是: %v", [resource.name, resource_values.app_engine_integration_mode])
    }
}
