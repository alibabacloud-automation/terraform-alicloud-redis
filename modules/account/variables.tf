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

variable "skip_region_validation" {
  description = "(Deprecated from version 1.3.0)Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

variable "region" {
  description = "(Deprecated from version 1.3.0)The region used to launch this module resources."
  default     = ""
}

################
# accounts
################

variable "create_account" {
  description = "Whether to create a new account. If true, the 'accounts' should not be empty."
  type        = bool
  default     = true
}

variable "redis_instance_id" {
  description = "The Id of instance in which database belongs."
  default     = ""
}

variable "accounts" {
  description = "A list mapping used to add multiple accounts. Each item supports keys: account_name, account_password, account_type (default to Normal) and account_privilege (default to RoleReadOnly)."
  type        = list(map(string))
  default     = []
}

