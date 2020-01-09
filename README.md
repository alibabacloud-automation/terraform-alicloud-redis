Terraform module which creates redis instnace and other resources on Alibaba Cloud   
terraform-alicloud-redis
==================================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/blob/master/README-CN.md)

Terraform module which creates Redis instnace and other resources on Alibaba Cloud 

These types of resources are supported:

* [alicloud_kvstore_instance](https://www.terraform.io/docs/providers/alicloud/d/kvstore_instances.html)
* [alicloud_kvstore_backup_policy](https://www.terraform.io/docs/providers/alicloud/r/kvstore_backup_policy.html)
* [alicloud_kvstore_account](https://www.terraform.io/docs/providers/alicloud/r/kvstore_account.html)

## Terraform versions

This module requires Terraform 0.12.

Usage
-----
    
```hcl
module "redis" {
  source               = "terraform-alicloud-modules/redis/alicloud"
  #################
  # Redis Instance
  #################
  engine               = "Redis"
  engine_version       = "5.0"
  region               = "cn-beijing"
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
}
```
## Modules

This module provides rich sub-modules to support different Redis version and usage scenario, like:

* [Redis 2.8 for Community Cluster](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-2.8-communtity-cluster)
* [Redis 4.0 for Community Read-Write split](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-4.0-communtity-rwsplit)
* [Enhanced performance Redis 5.0 for Enterprise Standard edition](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-5.0-enterprise-standard-enhanced-performance-type)
* [Enhanced performance Redis 5.0 for Enterprise Read-Write split](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-5.0-enterprise-rwsplit-enhanced-performance-type)
* [Enhanced performance Redis 5.0 for Enterprise Cluster](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules/redis-5.0-enterprise-cluster-enhanced-performance)

See [more modules](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/modules).

## Examples

* [Example of a Redis 5.0](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/redis-5.0)
* [Example of a Redis 4.0](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/redis-4.0)
* [Example of a Redis 2.8](https://github.com/terraform-alicloud-modules/terraform-alicloud-redis/tree/master/examples/redis-2.8)

## Notes

* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.


Authors
---------
Created and maintained by Yi Jincheng(yi785301535@163.com), He Guimin(@xiaozhu36, heguimin36@163.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

