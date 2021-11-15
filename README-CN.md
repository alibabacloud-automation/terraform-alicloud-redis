在阿里云上创建一个 Redis 实例和数据库  
terraform-alicloud-redis
=====================================================================


本 Module 用于在阿里云的 VPC 下创建一个[Redis云数据库](https://help.aliyun.com/document_detail/26342.html)。

本 Module 支持创建以下资源:

* [Redis 数据库实例 (redis_instance)](https://www.terraform.io/docs/providers/alicloud/r/kvstore_instances.html)
* [Redis 数据库实例的备份策略 (redis_backup_policy)](https://www.terraform.io/docs/providers/alicloud/r/kvstore_backup_policy.html)
* [Redis 数据库的账号 (redis_account)](https://www.terraform.io/docs/providers/alicloud/r/kvstore_account.html)
* [CmsAlarm 云监控实例 (cms_alarm)](https://www.terraform.io/docs/providers/alicloud/r/cms_alarm.html)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0

## 用法
    
#### 创建新的Rds实例(注意：4.0以上版本支持创建用户)

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

### 使用已经存在的Rds实例(注意：4.0以上版本支持创建用户)
    
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

## 示例

* [创建 Redis 完整示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/complete)
* [使用已经存在的 Redis 实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/using-existing-redis-instance)
* [Redis 2.8 创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/using-submodule-complete-redis-2.8)
* [Redis 4.0 创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/using-submodule-complete-redis-4.0)
* [Redis 5.0 创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/using-submodule-complete-redis-5.0)

## 模板

本 Module 提供了丰富多样的模板用于创建不同版本和规格的 Redis 资源，以满足不同的使用场景，如：

* [社区 Redis 2.8 集群版](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-2.8-communtity-cluster)
* [社区 Redis 4.0 读写分离版](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-4.0-communtity-rwsplit)
* [企业级 Redis 5.0 性能增强型标准版](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-5.0-enterprise-standard-enhanced-performance-type)
* [企业级 Redis 5.0 性能增强型读写分离版](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-5.0-enterprise-rwsplit-enhanced-performance-type)
* [企业级 Redis 5.0 性能增强型集群版](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-5.0-enterprise-cluster-enhanced-performance)

更多模板详见 [Modules](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules).

## 注意事项
本Module从版本v1.3.0开始已经移除掉如下的 provider 的显示设置：
```hcl
provider "alicloud" {
  profile = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region = var.region != "" ? var.region : null
  skip_region_validation = var.skip_region_validation
  configuration_source = "terraform-alicloud-modules/redis"
} 
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.2.0:

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
如果你想对正在使用中的Module升级到 1.3.0 或者更高的版本，那么你可以在模板中显示定义一个相同Region的provider：
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
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显示指定这个provider：

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}
module "redis" {
  source = "terraform-alicloud-modules/redis/alicloud"
  providers = {
    alicloud = alicloud.hz
  }
  alarm_rule_name            = "CmsAlarmForRedis"
  alarm_rule_statistics      = "Average"
  alarm_rule_period          = 300
  alarm_rule_operator        = "<="
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)


