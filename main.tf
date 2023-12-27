locals {
  this_instance_id      = var.existing_instance_id != "" ? var.existing_instance_id : concat(alicloud_kvstore_instance.this.*.id, [""])[0]
  create_more_resources = var.create_instance
  create_account        = local.create_more_resources && var.create_account
  project               = "acs_kvstore"
}

resource "alicloud_kvstore_instance" "this" {
  count                       = var.create_instance ? 1 : 0
  ssl_enable                  = var.ssl_enable
  instance_type               = "Redis"
  engine_version              = var.engine_version
  db_instance_name            = var.instance_name
  instance_class              = var.instance_class
  zone_id                     = var.availability_zone
  secondary_zone_id           = var.secondary_zone_id
  security_group_id           = var.security_group_id
  instance_release_protection = var.instance_release_protection
  vswitch_id                  = var.vswitch_id
  security_ips                = var.security_ips
  payment_type                = var.instance_charge_type
  period                      = var.period
  auto_renew                  = var.auto_renew
  auto_renew_period           = var.auto_renew_period
  private_ip                  = var.private_ip
  backup_id                   = var.instance_backup_id
  vpc_auth_mode               = var.vpc_auth_mode
  password                    = var.password
  kms_encrypted_password      = var.kms_encrypted_password
  kms_encryption_context      = var.kms_encryption_context
  maintain_start_time         = var.maintain_start_time
  maintain_end_time           = var.maintain_end_time
  config                      = var.config
  tags                        = var.tags
}

resource "alicloud_kvstore_backup_policy" "this" {
  count         = local.create_more_resources ? 1 : 0
  instance_id   = local.this_instance_id
  backup_period = var.backup_policy_backup_period
  backup_time   = var.backup_policy_backup_time
}

module "accounts" {
  source            = "./modules/account"
  create_account    = local.create_account
  redis_instance_id = local.this_instance_id
  accounts          = var.accounts
}

resource "alicloud_cms_alarm" "sharding_cpu_usage" {
  count             = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled           = var.enable_alarm_rule
  name              = var.alarm_rule_name
  project           = local.project
  metric            = "ShardingCpuUsage"
  metric_dimensions = "[{\"instanceId\":\"${local.this_instance_id}\",\"device\":\"/dev/vda1\"}]"
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "sharding_connection_usage" {
  count             = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled           = var.enable_alarm_rule
  name              = var.alarm_rule_name
  project           = local.project
  metric            = "ShardingConnectionUsage"
  metric_dimensions = "[{\"instanceId\":\"${local.this_instance_id}\",\"device\":\"/dev/vda1\"}]"
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "sharding_max_rt" {
  count             = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled           = var.enable_alarm_rule
  name              = var.alarm_rule_name
  project           = local.project
  metric            = "ShardingMaxRt"
  metric_dimensions = "[{\"instanceId\":\"${local.this_instance_id}\",\"device\":\"/dev/vda1\"}]"
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "sharding_memory_usage" {
  count             = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled           = var.enable_alarm_rule
  name              = var.alarm_rule_name
  project           = local.project
  metric            = "ShardingMemoryUsage"
  metric_dimensions = "[{\"instanceId\":\"${local.this_instance_id}\",\"device\":\"/dev/vda1\"}]"
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "sharding_used_connection" {
  count             = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled           = var.enable_alarm_rule
  name              = var.alarm_rule_name
  project           = local.project
  metric            = "ShardingUsedConnection"
  metric_dimensions = "[{\"instanceId\":\"${local.this_instance_id}\",\"device\":\"/dev/vda1\"}]"
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}

resource "alicloud_cms_alarm" "sharding_used_memory" {
  count             = local.create_more_resources && var.enable_alarm_rule ? 1 : 0
  enabled           = var.enable_alarm_rule
  name              = var.alarm_rule_name
  project           = local.project
  metric            = "ShardingUsedMemory"
  metric_dimensions = "[{\"instanceId\":\"${local.this_instance_id}\",\"device\":\"/dev/vda1\"}]"
  escalations_critical {
    statistics          = var.alarm_rule_statistics
    comparison_operator = var.alarm_rule_operator
    threshold           = var.alarm_rule_threshold
    times               = var.alarm_rule_triggered_count
  }
  period             = var.alarm_rule_period
  contact_groups     = var.alarm_rule_contact_groups
  silence_time       = var.alarm_rule_silence_time
  effective_interval = var.alarm_rule_effective_interval
}