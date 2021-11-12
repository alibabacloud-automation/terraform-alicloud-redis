#################
# Provider
#################

variable "profile" {
  description = "(Deprecated from version 1.3.0)The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = ""
}

variable "shared_credentials_file" {
  description = "(Deprecated from version 1.3.0)This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  default     = ""
}

variable "region" {
  description = "(Deprecated from version 1.3.0)The region used to launch this module resources."
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.3.0)Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

#############
# cms_alarm
#############
variable "enable_alarm_rule" {
  description = "Whether to enable alarm rule. Default to true. "
  type        = bool
  default     = true
}

variable "alarm_rule_name" {
  description = "The alarm rule name. "
  type        = string
  default     = ""
}

variable "alarm_rule_period" {
  description = "Index query cycle, which must be consistent with that defined for metrics. Default to 300, in seconds. "
  type        = number
  default     = 300
}

variable "alarm_rule_statistics" {
  description = "Statistical method. It must be consistent with that defined for metrics. Valid values: ['Average', 'Minimum', 'Maximum']. Default to 'Average'. "
  type        = string
  default     = "Average"
}

variable "alarm_rule_operator" {
  description = "Alarm comparison operator. Valid values: ['<=', '<', '>', '>=', '==', '!=']. Default to '=='. "
  type        = string
  default     = "=="
}

variable "alarm_rule_threshold" {
  description = "Alarm threshold value, which must be a numeric value currently. "
  type        = string
  default     = ""
}

variable "alarm_rule_triggered_count" {
  description = "Number of consecutive times it has been detected that the values exceed the threshold. Default to 3. "
  type        = number
  default     = 3
}

variable "alarm_rule_contact_groups" {
  description = "List contact groups of the alarm rule, which must have been created on the console. "
  type        = list(string)
  default     = []
}

variable "alarm_rule_silence_time" {
  description = "Notification silence period in the alarm state, in seconds. Valid value range: [300, 86400]. Default to 86400. "
  type        = number
  default     = 86400
}

variable "alarm_rule_effective_interval" {
  description = "The interval of effecting alarm rule. It foramt as 'hh:mm-hh:mm', like '0:00-4:00'."
  type        = string
  default     = "0:00-2:00"
}

#################
# Redis instance
#################
variable "password" {
  description = "The password of the redis instance."
  type        = string
  default     = ""
}

variable "kms_encrypted_password" {
  description = "An KMS encrypts password used to an instance. It is conflicted with 'password'."
  type        = string
  default     = ""
}

variable "kms_encryption_context" {
  description = "An KMS encryption context used to decrypt `kms_encrypted_password` before creating or updating an instance with 'kms_encrypted_password'."
  type        = map(string)
  default     = {}
}

variable "engine_version" {
  description = "Redis version. Value options can refer to the latest docs [CreateInstance](https://help.aliyun.com/document_detail/60862.html?spm=a2c4g.11186623.6.770.e0c735c10lvrqR) "
  default     = ""
}

variable "availability_zone" {
  description = "The available zone to launch Redis instance and other resources."
  default     = ""
}

variable "vswitch_id" {
  description = "The vswitch id used to launch one or more instances."
  default     = ""
}

variable "security_ips" {
  description = "List of IP addresses allowed to access all redis of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32])."
  type        = list(string)
  default     = []
}

variable "existing_instance_id" {
  description = "The Id of an existing redis instance. If set, the `create_instance` will be ignored."
  default     = ""
}

variable "instance_charge_type" {
  description = "Filter the results by charge type. Valid values: PrePaid and PostPaid. Default to PostPaid."
  default     = "PostPaid"
}

variable "instance_class" {
  description = "Redis instance type. Refer the Redis instance type reference, such as 'redis.master.small.default', 'redis.master.4xlarge.default', 'redis.sharding.mid.default' etc"
  default     = ""
}

variable "instance_name" {
  description = "Display name of the instance, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
  default     = "MyRedis"
}

variable "period" {
  description = "The duration that you will buy DB instance (in month). It is valid when instance_charge_type is PrePaid. Valid values: [1~9], 12, 24, 36. Default to 1"
  type        = number
  default     = 1
}

variable "auto_renew" {
  description = "Whether to renewal a DB instance automatically or not. It is valid when instance_charge_type is PrePaid. Default to false."
  type        = bool
  default     = false
}

variable "auto_renew_period" {
  description = "Auto-renewal period of an instance, in the unit of the month. It is valid when instance_charge_type is PrePaid. Valid value:[1~12], Default to 1."
  type        = number
  default     = 1
}

variable "private_ip" {
  description = "Set the instance's private IP."
  default     = ""
}

variable "instance_backup_id" {
  description = "If an instance created based on a backup set generated by another instance is valid, this parameter indicates the ID of the generated backup set"
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the redis instance resource."
  type        = map(string)
  default     = {}
}

variable "maintain_start_time" {
  description = "The start time of the operation and maintenance time period of the instance, in the format of HH:mmZ (UTC time)."
  default     = "02:00Z"
}

variable "maintain_end_time" {
  description = "The end time of the operation and maintenance time period of the instance, in the format of HH:mmZ (UTC time)."
  default     = "03:00Z"
}

variable "vpc_auth_mode" {
  description = "Only meaningful if instance_type is Redis and network type is VPC. Valid values are Close, Open. Defaults to Open. Close means the redis instance can be accessed without authentication. Open means authentication is required."
  default     = "Open"
}

#################
# Redis backup_policy
#################

variable "backup_policy_backup_period" {
  description = "Redis Instance backup policy backup period."
  type        = list(string)
  default     = []
}

variable "backup_policy_backup_time" {
  description = "Redis instance backup policy backup time, in the format of HH:mmZ- HH:mmZ."
  default     = "02:00Z-03:00Z"
}

#################
# Redis account
#################

variable "create_account" {
  description = "Whether to create a new account. If true, the 'accounts' should not be empty."
  type        = bool
  default     = true
}

variable "accounts" {
  description = "A list mapping used to add multiple accounts. Each item supports keys: account_name, account_password, account_type (default to Normal) and account_privilege (default to RoleReadOnly)."
  type        = list(map(string))
  default     = []
}
