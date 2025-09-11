package terraform.gcp.firestore.backup_schedule.weekly_recurrence

import data.terraform.gcp.helpers

default allow = false

# 检查所有 Firestore Backup Schedule 是否配置了 weekly_recurrence
allow {
    some resource
    resources := helpers.get_all_resources("google_firestore_backup_schedule")
    resource := resources[_]
    resource_values := resource.values
    resource_values.weekly_recurrence
}


violation[res] {
    resources := helpers.get_all_resources("google_firestore_backup_schedule")
    resource := resources[_]
    not resource.values.weekly_recurrence
    res := {
        "msg": sprintf("Backup schedule '%v' 未配置 weekly_recurrence", [resource.name])
    }
}
