data "alicloud_zones" "default" {
  available_resource_creation = "KVStore"
}

data "alicloud_cms_alarm_contact_groups" "default" {
}

data "alicloud_kvstore_instance_classes" "default" {
  engine         = "Redis"
  engine_version = var.engine_version
  zone_id        = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_kms_key" "kms" {
  key_usage              = "ENCRYPT/DECRYPT"
  pending_window_in_days = var.pending_window_in_days
  status                 = "Enabled"
}

resource "alicloud_kms_ciphertext" "kms" {
  plaintext = "test"
  key_id    = alicloud_kms_key.kms.id
  encryption_context = {
    test = "test"
  }
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones.0.id]
}

resource "alicloud_security_group" "default" {
  inner_access_policy = "Accept"
  name                = var.instance_name
  vpc_id              = module.vpc.this_vpc_id
}

module "redis_example" {
  source = "../.."

  #alicloud_kvstore_instance
  create_instance = true

  engine_version              = var.engine_version
  instance_name               = var.instance_name
  instance_class              = data.alicloud_kvstore_instance_classes.default.instance_classes.0
  availability_zone           = data.alicloud_zones.default.zones.0.id
  secondary_zone_id           = data.alicloud_zones.default.zones.1.id
  ssl_enable                  = "Enable"
  vswitch_id                  = module.vpc.this_vswitch_ids[0]
  security_ips                = var.security_ips
  security_group_id           = alicloud_security_group.default.id
  instance_charge_type        = var.instance_charge_type
  instance_release_protection = false
  period                      = var.period
  auto_renew                  = var.auto_renew
  auto_renew_period           = var.auto_renew_period
  private_ip                  = "172.16.0.10"
  vpc_auth_mode               = var.vpc_auth_mode
  password                    = var.password
  kms_encrypted_password      = var.kms_encrypted_password
  kms_encryption_context      = alicloud_kms_ciphertext.kms.encryption_context
  maintain_start_time         = var.maintain_start_time
  maintain_end_time           = var.maintain_end_time
  config                      = var.config
  tags                        = var.tags

  #alicloud_kvstore_backup_policy
  backup_policy_backup_period = var.backup_policy_backup_period
  backup_policy_backup_time   = var.backup_policy_backup_time

  #accounts
  create_account = true

  accounts = [
    {
      account_name      = "tf_account_name"
      account_password  = "YourPassword123!"
      account_type      = "Normal"
      account_privilege = var.account_privilege
    }
  ]

  #alicloud_cms_alarm
  enable_alarm_rule             = var.enable_alarm_rule
  alarm_rule_name               = var.alarm_rule_name
  alarm_rule_statistics         = var.alarm_rule_statistics
  alarm_rule_operator           = var.alarm_rule_operator
  alarm_rule_threshold          = var.alarm_rule_threshold
  alarm_rule_triggered_count    = var.alarm_rule_triggered_count
  alarm_rule_period             = var.alarm_rule_period
  alarm_rule_contact_groups     = data.alicloud_cms_alarm_contact_groups.default.names
  alarm_rule_silence_time       = var.alarm_rule_silence_time
  alarm_rule_effective_interval = var.alarm_rule_effective_interval
}