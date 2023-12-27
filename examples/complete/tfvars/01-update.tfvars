# alicloud_kms_key
pending_window_in_days = 7

# Redis instance
engine_version         = "5.0"
instance_name          = "update-tf-testacc-name"
security_ips           = ["10.23.12.24"]
period                 = 2
auto_renew             = true
auto_renew_period      = 2
vpc_auth_mode          = "Close"
password               = "YourPassword123!update"
kms_encrypted_password = "YourPassword123!update"
maintain_start_time    = "01:00Z"
maintain_end_time      = "02:00Z"
config = {
  appendonly             = "no"
  lazyfree-lazy-eviction = "no"
  maxmemory-policy       = "volatile-lru"
}
tags = {
  Name = "updateREDIS"
}

# Redis backup_policy
backup_policy_backup_period = ["Tuesday", "Wednesday"]
backup_policy_backup_time   = "01:00Z-02:00Z"

# Redis account
account_privilege = "RoleReadOnly"

# cms_alarm
enable_alarm_rule             = false
alarm_rule_name               = "update-tf-testacc-rule"
alarm_rule_statistics         = "Maximum"
alarm_rule_operator           = "<="
alarm_rule_threshold          = "35"
alarm_rule_triggered_count    = 5
alarm_rule_period             = 900
alarm_rule_silence_time       = 10000
alarm_rule_effective_interval = "1:00-3:00"
