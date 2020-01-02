
provider "alicloud" {
  version                 = ">=1.64.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/KVStore"
}
resource "alicloud_kvstore_instance" "this" {
  count                = var.existing_instance_id != "" ? 0 : var.create_instance ? 1 : 0
  instance_class       = var.instance_class
  instance_name        = var.instance_name
  engine_version       = var.engine_version
  vswitch_id           = var.vswitch_id != "" ? var.vswitch_id : data.alicloud_vswitches.this.ids[count.index]
  security_ips         = var.security_ips
  availability_zone    = var.availability_zone != "" ? var.availability_zone : data.alicloud_vswitches.this.vswitches.0.zone_id
  instance_charge_type = var.instance_charge_type
}

resource "alicloud_kvstore_backup_policy" "this" {
  count         = var.create_backup_policy && var.account_name != "" ? 1 : 0
  instance_id   = alicloud_kvstore_instance.this.0.id
  backup_period = var.backup_period
  backup_time   = var.backup_time
}
resource "alicloud_kvstore_account" "this" {
  count            = var.create_account && var.account_name != "" ? 1 : 0
  instance_id      = alicloud_kvstore_instance.this.0.id
  account_name     = var.account_name
  account_password = var.account_password
}

