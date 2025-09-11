package terraform.gcp.firestore.backup_schedule.retention

import data.terraform.gcp.helpers

default allow = false

# 允许规则：所有 Firestore Backup Schedule 的 retention 不小于 604800 秒（7 天）
allow {
    some resource
    resources := helpers.get_all_resources("google_firestore_backup_schedule")
    resource := resources[_]
    resource_values := resource.values
    retention_seconds := parse_duration(resource_values.retention)
    retention_seconds >= 604800
}

# 违规规则：retention 小于 7 天
violation[res] {
    resources := helpers.get_all_resources("google_firestore_backup_schedule")
    resource := resources[_]
    resource_values := resource.values
    retention_seconds := parse_duration(resource_values.retention)
    retention_seconds < 604800
    res := {
        "msg": sprintf("Backup schedule '%v' 的 retention 配置小于 7 天: %v 秒", [resource.name, retention_seconds])
    }
}

# 辅助函数：将 '8467200s' 这类字符串转为秒数
parse_duration(str) = seconds {
    endswith(str, "s")
    seconds := to_number(trim_suffix(str, "s"))
}
