
output "this_kv_instance_id" {
  value = module.redis_example.this_kv_instance_id
}
output "this_kv_instance_type" {
  value = module.redis_example.this_kv_instance_type
}
output "this_kv_instance_engine_version" {
  value = module.redis_example.this_kv_instance_engine_version
}

output "this_kv_instance_instance_name" {
  value = module.redis_example.this_kv_instance_instance_name
}

output "this_kv_instance_availability_zone" {
  value = module.redis_example.this_kv_instance_availability_zone
}

output "this_kv_instance_security_ips" {
  value = module.redis_example.this_kv_instance_security_ips
}
output "this_kv_instance_class" {
  value = module.redis_example.this_kv_instance_class
}
output "this_kv_instance_account" {
  value = module.redis_example.this_kv_instance_account
}
#vpc
output "this_vpc_id" {
  value = module.vpc.this_vpc_id
}
output "this_vpc_cidr_block" {
  value = module.vpc.this_vpc_cidr_block
}
output "this_vpc_vswitch_ids" {
  value = module.vpc.this_vswitch_ids
}
output "this_vpc_availability_zones" {
  value = module.vpc.this_availability_zones
}
