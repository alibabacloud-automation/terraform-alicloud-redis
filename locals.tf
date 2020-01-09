locals {
  #instance
  this_instance_id      = var.existing_instance_id != "" ? var.existing_instance_id : concat(alicloud_kvstore_instance.this.*.id, [""])[0]
  create_more_resources = var.existing_instance_id != "" || var.create_instance ? true : false
  create_account        = local.create_more_resources && var.create_account
}
