package terraform.gcp.firestore.backup_schedule.daily_recurrence

import data.terraform.gcp.helpers

default allow = false

# 检查所有 Firestore Backup Schedule 是否配置了 daily_recurrence
allow {
    some resource
    resources := helpers.get_all_resources("google_firestore_backup_schedule")
    resource := resources[_]
    resource_values := resource.values
    resource_values.daily_recurrence
}

# 示例 deny 规则：未配置 daily_recurrence 的资源
violation[res] {
    resources := helpers.get_all_resources("google_firestore_backup_schedule")
    resource := resources[_]
    not resource.values.daily_recurrence
    res := {
        "msg": sprintf("Backup schedule '%v' 未配置 daily_recurrence", [resource.name])
    }
}
