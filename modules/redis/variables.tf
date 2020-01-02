
variable "instance_class" {
  description = "Redis instance type. Refer the Redis instance type reference, such as 'redis.master.small.default', 'redis.master.4xlarge.default', 'redis.sharding.mid.default' etc"
  default     = ""
}

variable "instance_name" {
  description = " Display name of the instance, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
  default     = ""
}

variable "password" {
  default = ""
}

variable "availability_zone" {
  description = "The available zone to launch ecs instance and other resources."
  default     = ""
}

# VSwitch variables
/*variable "vswitch_id" {
  description = "The vswitch id used to launch one or more instances."
  default     = ""
}*/

/*variable "vswitch_cidr" {
  description = "The cidr block used to launch a new vswitch when 'vswitch_id' is not specified."
  default     = "172.16.0.0/16"
}*/

variable "backup_period" {
  description = "DB Instance backup period."
  type        = list(string)
  default     = []
}

variable "security_ips" {
  description = " List of IP addresses allowed to access all redis of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32])."
  type        = list(string)
  default     = []
}
variable "instance_charge_type" {
  description = "Filter the results by charge type. Valid values: PrePaid and PostPaid. Default to PostPaid."
  default     = "Postpaid"
}
//
//variable "vpc_auth_mode" {
//  description = "Only meaningful if instance_type is `Redis` and network type is VPC. Valid values are `Close`, `Open`. Defaults to `Open`.  `Close` means the redis instance can be accessed without authentication. `Open` means authentication is required."
//  default     = "Open"
//}
//variable "vpc_name" {
//  description = "The vpc name used to launch a new vpc when 'vpc_id' is not specified."
//  default     = ""
//}
//
//variable "vpc_cidr" {
//  description = "The cidr block used to launch a new vpc when 'vpc_id' is not specified."
//  default     = ""
//}

variable "backup_time" {
  description = " redis instance backup time, in the format of HH:mmZ- HH:mmZ. "
  default     = "02:00Z-03:00Z"
}
//
//variable "create_instance" {
//  description = "Create instance"
//  default     = true
//}

//variable "create_backup_policy" {
//  description = "Adding DB backup policy"
//  default     = false
//}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = ""
}

variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  default     = ""
}

variable "region" {
  description = "The region used to launch this module resources."
  default     = "cn-beijing"
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  default     = false
}
variable "period" {
  description = "The duration that you will buy DB instance (in month). It is valid when instance_charge_type is PrePaid. Valid values: [1~9], 12, 24, 36. Default to 1"
  type        = number
  default     = 1
}
//variable "vswitch_cidr" {
//  description = "The cidr block used to launch a new vswitch when 'vswitch_id' is not specified."
//  default     = ""
//}
//
//variable "vswitch_name" {
//  description = "The vswitch name used to launch a new vswitch when 'vswitch_id' is not specified."
//  default     = ""
//}
variable "vswitch_id" {
  description = "The vswitch id used to launch one or more instances."
  default     = ""
}
variable "account_name" {
  description = "Operation account requiring a uniqueness check. It may consist of lower case letters, numbers, and underlines, and must start with a letter and have no more than 16 characters."
  default     = ""
}
variable "account_password" {
  description = "Operation password. It may consist of letters, digits, or underlines, with a length of 6 to 32 characters. You have to specify one of account_password and kms_encrypted_password fields."
  default     = ""
}