
output "this_kv_instance_id" {
  value = alicloud_kvstore_instance.this.*.id
}

output "this_kv_instance_engine_version" {
  value = alicloud_kvstore_instance.this.*.engine_version
}

output "this_kv_instance_instance_name" {
  value = alicloud_kvstore_instance.this.*.instance_name
}

output "this_kv_instance_availability_zone" {
  value = alicloud_kvstore_instance.this.*.availability_zone
}

output "this_kv_instance_security_ips" {
  value = alicloud_kvstore_instance.this.*.security_ips
}
output "this_kv_instance_class" {
  value = alicloud_kvstore_instance.this.*.instance_class
}
output "this_kv_instance_type" {
  value = alicloud_kvstore_instance.this.*.instance_type
}
output "this_kv_instance_account" {
  value = alicloud_kvstore_account.this.*.account_name
}
