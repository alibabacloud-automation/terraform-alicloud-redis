# Alibaba Cloud Redis-Accounts

Configuration in this directory creates set of Redis resources including  instance,  account and backup policy.

## Usage

To run this example you need to execute:

```bash
module "redis" {
  source  = "terraform-alicloud-modules/redis/alicloud//modules/account"
  version = "~> 1.0"

  # omitted...
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->