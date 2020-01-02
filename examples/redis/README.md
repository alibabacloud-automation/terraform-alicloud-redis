# Alibaba Cloud Redis Instance Terraform Module   
terraform-alicloud-rds
---

This Terraform module will first creates a vpc instance, then create a Redis instance to this instance.
Also you can config the backup policy of instance created on Alibaba Cloud.

These types of resources are supported:

* [Alicloud_kvstore_instances](https://www.terraform.io/docs/providers/alicloud/d/kvstore_instances.html)
* [Alicloud_kvstore_backup_policy](https://www.terraform.io/docs/providers/alicloud/r/kvstore_backup_policy.html)
* [Alicloud_kvstore_account](https://www.terraform.io/docs/providers/alicloud/r/kvstore_account.html)

----------------------


Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf
    
```hcl
module "redis_example" {
  source               = "../../modules/redis"
  region               = "cn-beijing"
  instance_name        = "myTest"
  instance_class       = "redis.master.mid.default"
  instance_charge_type = "PostPaid"
  period               = 1
  vswitch_id           = data.alicloud_vswitches.default.ids.0
  security_ips         = ["1.1.1.1", "2.2.2.2", "3.3.3.3"]
  backup_time          = "02:00Z-03:00Z"
  backup_period        = ["Monday", "Wednesday", "Friday"]
  account_name         = "redisTest"
  account_password     = "123456Abc"

}
```

2. Setting `access_key` and `secret_key` values through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY
    - ALICLOUD_REGION


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|engine               | Engine type. Value options: Redis and Memcache .    |  string     |     Redis      | yes |  
|engine_version       | Engine version. Value options:<br>2.8/4.0/5.0 for Redis ;<br>2.8 for Memcache   |   string  |    2.8    |    yes       | 
|instance_class       | Type of the applied ApsaraDB for Redis instance. For details, see [Instance type table](https://www.alibabacloud.com/help/doc-detail/26350.htm?spm=a2c63.l28256.b99.13.271d5175pIy8vr).   |     string  |  redis.master.mid.default   |    yes       |  
|instance_name        | The name of DB instance. It a string of 2 to 256 characters.    |  string     |     myTest      |    no       | 
|instance_charge_type | Valid values are Prepaid, Postpaid, Default to Postpaid.  |  string     |     PostPaid      |     no      |  = "PostPaid"
|availability_zone    | The Zone to launch the DB instance. From version 1.8.1, it supports multiple zone. If it is a multi-zone and vswitch_id is specified, the vswitch must in the one of them. The multiple zone ID can be retrieved by setting multi to "true" in the data source alicloud_zones.  |  string     |     cn-hangzhou-b      |   no        |  
|security_ips         | List of IP addresses allowed to access all databases of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32]).    |   list    |    []      |      no     |  


## Outputs

| Name | Description |
|------|-------------|
| this_kv_instance_id     |        instance ID created     |
| this_db_instance_type     |    instance type created         |
| this_kv_instance_engine_version     |   instance engine version created          |
| this_kv_instance_instance_name     |     instance name created        |
| this_kv_instance_class     |      instance class created       |
| this_kv_instance_availability_zone     |       instance availability zone  created      |
| this_kv_instance_security_ips     |    instance security ips configured         |
| this_kv_instance_account     |    redis account associated in this instance          |


Authors
---------

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
