resource "alicloud_kvstore_account" "this" {
  count             = var.create_account ? length(var.accounts) : 0
  instance_id       = var.redis_instance_id
  account_name      = lookup(var.accounts[count.index], "account_name")
  account_password  = lookup(var.accounts[count.index], "account_password")
  account_type      = lookup(var.accounts[count.index], "account_type", "Normal")
  account_privilege = lookup(var.accounts[count.index], "account_privilege", "RoleReadWrite")
}