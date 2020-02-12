variable "region" {
  default = "cn-beijing"
}
provider "alicloud" {
  region = var.region
}

module "redis_example" {
  source = "../../"
  region = var.region

  #################
  # Redis Instance
  #################

  existing_instance_id = "r-2zea81b836xxxxxx"

  #################
  # Redis backup_policy
  #################

  backup_policy_backup_time   = "02:00Z-03:00Z"
  backup_policy_backup_period = ["Monday", "Wednesday", "Friday"]

  #################
  # Redis account
  #################

  create_account = false
  accounts = [
    {
      account_name      = "user1"
      account_password  = "plan111111"
      account_privilege = "RoleReadOnly"
      account_type      = "Normal"
    },
    {
      account_name     = "user2"
      account_password = "plan222222"
    },
  ]

  #############
  # cms_alarm
  #############
  alarm_rule_name            = "CmsAlarmForRedis"
  alarm_rule_statistics      = "Average"
  alarm_rule_period          = 300
  alarm_rule_operator        = "<="
  alarm_rule_threshold       = 35
  alarm_rule_triggered_count = 2
  alarm_rule_contact_groups  = ["AccCms"]
}