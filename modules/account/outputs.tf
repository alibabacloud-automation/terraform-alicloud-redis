output "this_redis_instance_account_name" {
  description = "This Redis instance account name."
  value       = alicloud_kvstore_account.this.*.account_name
}