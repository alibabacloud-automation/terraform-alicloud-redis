Terraform module which creates redis instnace and other resources on Alibaba Cloud
# terraform-alicloud-redis
=====================================================================


本 Module 用于在阿里云的 VPC 下创建一个[Redis云数据库](https://help.aliyun.com/document_detail/26342.html). 

本 Module 支持创建以下资源:

* [Redis 数据库实例_(redis_instance)](https://www.terraform.io/docs/providers/alicloud/d/kvstore_instances.html)
* [Redis 数据库实例的备份策略_(redis_backup_policy)](https://www.terraform.io/docs/providers/alicloud/r/kvstore_backup_policy.html)
* [Redis 数据库的账号_(redis_account)](https://www.terraform.io/docs/providers/alicloud/r/kvstore_account.html)

## Terraform 版本

本模板要求使用版本 Terraform 0.12。

## 用法

```hcl
module "redis_example" {
  source               = "terraform-alicloud-modules/redis/alicloud/"
  #################
  # Redis Instance
  #################
  engine               = "Redis"
  engine_version       = "5.0"
  region               = "cn-beijing"
  instance_name        = "myInstance"
  instance_class       = "redis.master.mid.default"
  period               = 1
  vswitch_id           = "vsw-bp1tili2u5kpgdk84osjk"
  security_ips         = ["1.1.1.1", "2.2.2.2", "3.3.3.3"]
  availability_zone    = "cn-beijing-f"
  vswitch_id           = "vsw-2zeuq8sx0ikfj73ev2iah"
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

  #####################
  # Redis backup_policy
  #####################

  backup_policy_backup_time    = "02:00Z-03:00Z"
  backup_policy_backup_period  = ["Monday", "Wednesday", "Friday"]
}
```

## 示例

* [Redis 实例完整创建示例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/redis)

## 注意事项

* 本 Module 使用的 AccessKey 和 SecretKey 可以直接从 `profile` 和 `shared_credentials_file` 中获取。如果未设置，可通过下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置.

作者
-------
Created and maintained by Yi Jincheng(yi785301535@163.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)


