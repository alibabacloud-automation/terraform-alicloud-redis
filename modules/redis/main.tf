provider "alicloud" {
  version                 = ">=1.64.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
}
locals {
  engine         = "Redis"
  engine_version = "5.0"
}

data "alicloud_zones" "default" {
  available_resource_creation = "KVStore"
  multi                       = true
  enable_details              = true

}

data "alicloud_kvstore_instance_classes" "default" {
  engine         = local.engine
  engine_version = local.engine_version
  zone_id        = data.alicloud_zones.default.zones.0.multi_zone_ids.0
}
module "redis" {

  source               = "../.."
  region               = var.region
  engine_version       = local.engine_version
  instance_name        = var.instance_name
  instance_class       = var.instance_class != "" ? var.instance_class : data.alicloud_kvstore_instance_classes.default.instance_classes.0
  security_ips         = var.security_ips
  instance_charge_type = var.instance_charge_type
  period               = var.period
  //todo Vswitch Availability Zone created by vpc module does not exist in Multi-AZ
  availability_zone    =  var.availability_zone//data.alicloud_zones.default.zones.0.multi_zone_ids.0
  vswitch_id           = var.vswitch_id
  backup_time          = var.backup_time
  backup_period        = var.backup_period
  account_password     = var.account_password
  account_name         = var.account_name
}
