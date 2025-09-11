package terraform.gcp.firestore.database.location_id

import data.terraform.gcp.helpers

default allow = false

# 允许规则：所有 Firestore Database 的 location_id 必须为 "nam5"
allow {
    some resource
    resources := helpers.get_all_resources("google_firestore_database")
    resource := resources[_]
    resource_values := resource.values
    resource_values.location_id == "nam5"
}

# 违规规则：location_id 未设置为 nam5
violation[res] {
    resources := helpers.get_all_resources("google_firestore_database")
    resource := resources[_]
    resource_values := resource.values
    not resource_values.location_id == "nam5"
    res := {
        "msg": sprintf("Firestore database '%v' 的 location_id 未设置为 nam5，而是: %v", [resource.name, resource_values.location_id])
    }
}
