provider "alicloud" {
  region = "cn-beijing"
}
module "vpc" {
  source       = "alibaba/vpc/alicloud"
  vpc_name     = "my_module_vpc"
  vswitch_name = "my_module_vswitch"
  vswitch_cidrs = [
    "172.16.1.0/24",
    "172.16.2.0/24"
  ]
}

data "alicloud_vswitches" "default" {
  vpc_id = module.vpc.this_vpc_id
  ids    = [module.vpc.this_vswitch_ids.0]
}
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
  account_name         = "tftestnormal"
  account_password     = "123456Abc"
  availability_zone   = data.alicloud_vswitches.default.zone_id
}





