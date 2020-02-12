provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/redis"
}

resource "alicloud_kvstore_account" "this" {
  count             = var.create_account ? length(var.accounts) : 0
  instance_id       = var.redis_instance_id
  account_type      = lookup(var.accounts[count.index], "account_type", "Normal")
  account_name      = lookup(var.accounts[count.index], "account_name")
  account_password  = lookup(var.accounts[count.index], "account_password")
  account_privilege = lookup(var.accounts[count.index], "account_privilege", "RoleReadWrite")
}