package terraform.gcp.firestore.database.concurrency_mode

import data.terraform.gcp.helpers

default allow = false

# 允许规则：所有 Firestore Database 的 concurrency_mode 必须为 OPTIMISTIC
allow {
    some resource
    resources := helpers.get_all_resources("google_firestore_database")
    resource := resources[_]
    resource_values := resource.values
    resource_values.concurrency_mode == "OPTIMISTIC"
}

# 违规规则：concurrency_mode 未设置为 OPTIMISTIC
violation[res] {
    resources := helpers.get_all_resources("google_firestore_database")
    resource := resources[_]
    resource_values := resource.values
    not resource_values.concurrency_mode == "OPTIMISTIC"
    res := {
        "msg": sprintf("Firestore database '%v' 的 concurrency_mode 未设置为 OPTIMISTIC，而是: %v", [resource.name, resource_values.concurrency_mode])
    }
}
