Terraform module which creates redis instance and other resources on Alibaba Cloud   
terraform-alicloud-redis
==================================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/blob/master/README-CN.md)

Terraform module which creates Redis instance and other resources on Alibaba Cloud 

These types of resources are supported:

* [alicloud_kvstore_instance](https://www.terraform.io/docs/providers/alicloud/r/kvstore_instances.html)
* [alicloud_kvstore_backup_policy](https://www.terraform.io/docs/providers/alicloud/r/kvstore_backup_policy.html)
* [alicloud_kvstore_account](https://www.terraform.io/docs/providers/alicloud/r/kvstore_account.html)
* [Alicloud_cms_alarm](https://www.terraform.io/docs/providers/alicloud/r/cms_alarm.html)

## Terraform versions

This module requires Terraform 0.12 and Terraform Provider Alicloud 1.56.0+.

Usage
-----
    
For new instance
Be careful:Create Account supports redis instances of version 4.0 or above.

```hcl
module "redis" {
  source               = "terraform-alicloud-modules/redis/alicloud"
  region               = "cn-beijing"
  #################
  # Redis Instance
  #################
  engine               = "Redis"
  engine_version       = "5.0"
  instance_name        = "myInstance"
  instance_class       = "redis.master.mid.default"
  period               = 1
  vswitch_id           = "vsw-bp1tili2xxxxx"
  security_ips         = ["1.1.1.1", "2.2.2.2", "3.3.3.3"]
  availability_zone    = "cn-beijing-f"
  security_ips         = ["1.1.1.1", "2.2.2.2", "3.3.3.3"]
  instance_charge_type = "PostPaid"
  tags = {
    Env      = "Private"
    Location = "Secret"
  }

  #################
  # Redis Accounts
  #################

  accounts = [
    {
      account_name      = "user1"
      account_password  = "plan111111"
      account_privilege = "RoleReadOnly"
      account_type      = "Normal"
    },
    {
      account_name      = "user2"
      account_password  = "plan222222"
    },
  ]

  #################
  # Redis backup_policy
  #################

  backup_policy_backup_time    = "02:00Z-03:00Z"
  backup_policy_backup_period  = ["Monday", "Wednesday", "Friday"]

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
```

For existing instance 
Be careful:Create Account supports redis instances of version 4.0 or above.
    
```hcl
module "redis" {
  source               = "terraform-alicloud-modules/redis/alicloud"
  region               = "cn-beijing"
  #################
  # Redis Instance
  #################

  existing_instance_id = "r-2zea81b836xxxxx"

  #################
  # Redis Accounts
  #################

  create_account = true  
  accounts = [
    {
      account_name      = "user1"
      account_password  = "plan111111"
      account_privilege = "RoleReadOnly"
      account_type      = "Normal"
    },
    {
      account_name      = "user2"
      account_password  = "plan222222"
    },
  ]

  #################
  # Redis backup_policy
  #################

  backup_policy_backup_time    = "02:00Z-03:00Z"
  backup_policy_backup_period  = ["Monday", "Wednesday", "Friday"]

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
```

## Examples

* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/complete)
* [using-existing-redis-instance](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/using-existing-redis-instance)
* [using-submodule-complete-redis-2.8](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/using-submodule-complete-redis-2.8)
* [using-submodule-complete-redis-4.0](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/using-submodule-complete-redis-4.0)
* [using-submodule-complete-redis-5.0](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/using-submodule-complete-redis-5.0)

## Modules

This module provides rich sub-modules to support different Redis version and usage scenario, like:

* [Redis 2.8 for Community Cluster](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-2.8-communtity-cluster)
* [Redis 4.0 for Community Read-Write split](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-4.0-communtity-rwsplit)
* [Enhanced performance Redis 5.0 for Enterprise Standard edition](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-5.0-enterprise-standard-enhanced-performance-type)
* [Enhanced performance Redis 5.0 for Enterprise Read-Write split](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-5.0-enterprise-rwsplit-enhanced-performance-type)
* [Enhanced performance Redis 5.0 for Enterprise Cluster](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-5.0-enterprise-cluster-enhanced-performance)

See [more modules](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules).

## Notes

* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.


Authors
---------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

