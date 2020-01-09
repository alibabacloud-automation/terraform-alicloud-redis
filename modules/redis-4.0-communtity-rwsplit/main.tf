provider "alicloud" {
  version                 = ">=1.68.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/redis"
}
locals {
  engine         = "Redis"
  engine_version = "4.0"
  edition_type   = "Community"
  architecture   = "rwsplit"
}

data "alicloud_kvstore_instance_classes" "default" {
  engine         = local.engine
  engine_version = local.engine_version
  zone_id        = var.availability_zone
  edition_type   = local.edition_type
  architecture   = local.architecture
}
module "redis" {

  source         = "../.."
  region         = var.region
  engine_version = local.engine_version

  #################
  # Redis Instance
  #################

  instance_name        = var.instance_name
  instance_class       = var.instance_class != "" ? var.instance_class : data.alicloud_kvstore_instance_classes.default.instance_classes.0
  security_ips         = var.security_ips
  availability_zone    = var.availability_zone
  instance_charge_type = var.instance_charge_type
  period               = var.period
  vswitch_id           = var.vswitch_id
  auto_renew           = var.auto_renew
  auto_renew_period    = var.auto_renew_period
  private_ip           = var.private_ip
  instance_backup_id   = var.instance_backup_id
  tags                 = var.tags
  vpc_auth_mode        = var.vpc_auth_mode
  maintain_start_time  = var.maintain_start_time
  maintain_end_time    = var.maintain_end_time

  #################
  # Redis backup_policy
  #################

  backup_policy_backup_time   = var.backup_policy_backup_time
  backup_policy_backup_period = var.backup_policy_backup_period

  #################
  # Redis account
  #################

  accounts       = var.accounts
  create_account = var.create_account
}
