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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0

Usage
-----
    
For new instance
Be careful:Create Account supports redis instances of version 4.0 or above.

```hcl
module "redis" {
  source               = "terraform-alicloud-modules/redis/alicloud"
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
From the version v1.3.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region = var.region != "" ? var.region : null
  skip_region_validation = var.skip_region_validation
  configuration_source = "terraform-alicloud-modules/redis"
} 
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.2.0:

```hcl
module "redis" {
  source = "terraform-alicloud-modules/redis/alicloud"
  version     = "1.2.0"
  region      = "cn-hangzhou"
  profile     = "Your-Profile-Name"

  alarm_rule_name            = "CmsAlarmForRedis"
  alarm_rule_statistics      = "Average"
  alarm_rule_period          = 300
  alarm_rule_operator        = "<="
}
```

If you want to upgrade the module to 1.3.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
   region  = "cn-hangzhou"
   profile = "Your-Profile-Name"
}
module "redis" {
  source = "terraform-alicloud-modules/redis/alicloud"
  alarm_rule_name            = "CmsAlarmForRedis"
  alarm_rule_statistics      = "Average"
  alarm_rule_period          = 300
  alarm_rule_operator        = "<="
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}
module "redis" {
  source  = "terraform-alicloud-modules/redis/alicloud"
  providers = {
    alicloud = alicloud.hz
  }
  alarm_rule_name            = "CmsAlarmForRedis"
  alarm_rule_statistics      = "Average"
  alarm_rule_period          = 300
  alarm_rule_operator        = "<="
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.
More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

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