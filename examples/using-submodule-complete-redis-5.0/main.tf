variable "region" {
  default = "cn-beijing"
}
provider "alicloud" {
  region = var.region
}
resource "random_uuid" "default" {
}
locals {
  name = substr("tf-example-${replace(random_uuid.default.result, "-", "")}", 0, 16)
}

data "alicloud_zones" "default" {
  available_resource_creation = "KVStore"
}

resource "alicloud_vpc" "default" {
  vpc_name   = local.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = local.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

module "redis_example" {
  source = "../../modules/redis-5.0-communtity-cluster"
  region = var.region

  #################
  # Redis Instance
  #################

  instance_name     = local.name
  instance_class    = "redis.master.mid.default"
  period            = 1
  availability_zone = data.alicloud_zones.default.zones.0.id
  vswitch_id        = alicloud_vswitch.default.id
  security_ips      = ["1.1.1.1", "2.2.2.2", "3.3.3.3"]
  tags = {
    Env      = "Private"
    Location = "Secret"
  }

  #################
  # Redis backup_policy
  #################

  backup_policy_backup_time   = "02:00Z-03:00Z"
  backup_policy_backup_period = ["Monday", "Wednesday", "Friday"]

  #################
  # Redis account
  #################

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