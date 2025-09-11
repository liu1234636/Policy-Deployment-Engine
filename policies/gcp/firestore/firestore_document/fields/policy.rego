package terraform.gcp.firestore.document.fields

import data.terraform.gcp.helpers

default allow = false

# 允许规则：所有 Firestore Document 的 fields 必须包含 name 为 "field1" 和 "field2"
allow {
    some resource
    resources := helpers.get_all_resources("google_firestore_document")
    resource := resources[_]
    resource_values := resource.values
    has_required_fields(resource_values.fields)
}

# 违规规则：fields 不包含必需字段
violation[res] {
    resources := helpers.get_all_resources("google_firestore_document")
    resource := resources[_]
    resource_values := resource.values
    not has_required_fields(resource_values.fields)
    res := {
        "msg": sprintf("Firestore document '%v' 的 fields 未包含 field1 和 field2", [resource.name])
    }
}

# 辅助函数：检查 fields 是否包含 field1 和 field2
has_required_fields(fields) {
    some i
    some j
    fields[i].name == "field1"
    fields[j].name == "field2"
}
