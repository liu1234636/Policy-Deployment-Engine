package terraform.gcp.firestore.document.collection

import data.terraform.gcp.helpers

default allow = false

# 允许规则：所有 Firestore Document 的 collection 必须为 "my_collection"
allow {
    some resource
    resources := helpers.get_all_resources("google_firestore_document")
    resource := resources[_]
    resource_values := resource.values
    resource_values.collection == "my_collection"
}

# 违规规则：collection 未设置为 my_collection
violation[res] {
    resources := helpers.get_all_resources("google_firestore_document")
    resource := resources[_]
    resource_values := resource.values
    not resource_values.collection == "my_collection"
    res := {
        "msg": sprintf("Firestore document '%v' 的 collection 未设置为 my_collection，而是: %v", [resource.name, resource_values.collection])
    }
}
