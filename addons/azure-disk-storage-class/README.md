<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_storage_class_v1.single_az_sc](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key to Encrypt storage class. | `string` | `""` | no |
| <a name="input_single_az_storage_class"></a> [single\_az\_storage\_class](#input\_single\_az\_storage\_class) | Enable Single az storage class. | `bool` | `false` | no |
| <a name="input_single_az_storage_class_name"></a> [single\_az\_storage\_class\_name](#input\_single\_az\_storage\_class\_name) | Name for the single az storage class | `string` | `""` | no |
| <a name="input_storage_class_name"></a> [storage\_class\_name](#input\_storage\_class\_name) | storage class name | `string` | `""` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | List of Zones | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
