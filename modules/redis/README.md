# Redis-5.0 Alibaba Cloud KVStore Terraform Module

Configuration in this directory creates set of Redis resources including  instance,  account and backup policy.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Outputs

| Name | Description |
|------|-------------|
| this_kv_instance_id     |        instance ID created     |
| this_db_instance_type     |    instance type created         |
| this_kv_instance_engine_version     |   instance engine version created          |
| this_kv_instance_instance_name     |     instance name created        |
| this_kv_instance_class     |      instance class created       |
| this_kv_instance_availability_zone     |       instance availability zone  created      |
| this_kv_instance_security_ips     |    instance security ips configured         |
| this_kv_instance_account     |    redis account associated in this instance          |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
