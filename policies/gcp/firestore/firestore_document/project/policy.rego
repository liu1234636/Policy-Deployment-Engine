package terraform.gcp.firestore.document.project

import data.terraform.gcp.helpers

default allow = false

# 允许规则：所有 Firestore Document 的 project 必须为 "abcd_1234"
allow {
    some resource
    resources := helpers.get_all_resources("google_firestore_document")
    resource := resources[_]
    resource_values := resource.values
    resource_values.project == "abcd_1234"
}

# 违规规则：project 未设置为 abcd_1234
violation[res] {
    resources := helpers.get_all_resources("google_firestore_document")
    resource := resources[_]
    resource_values := resource.values
    not resource_values.project == "abcd_1234"
    res := {
        "msg": sprintf("Firestore document '%v' 的 project 未设置为 abcd_1234，而是: %v", [resource.name, resource_values.project])
    }
}
