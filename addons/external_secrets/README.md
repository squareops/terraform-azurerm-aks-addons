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
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.6 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.13 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa"></a> [irsa](#module\_irsa) | ./irsa | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.external_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.external_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Fetch ID of the cluster | `string` | `""` | no |
| <a name="input_cluster_issuer_url"></a> [cluster\_issuer\_url](#input\_cluster\_issuer\_url) | n/a | `string` | `""` | no |
| <a name="input_enable_service_monitor"></a> [enable\_service\_monitor](#input\_enable\_service\_monitor) | (optional) describe your variable | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment identifier for the EKS cluster | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Specify the name of the resource | `string` | `""` | no |
| <a name="input_provider_url"></a> [provider\_url](#input\_provider\_url) | n/a | `string` | `""` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | AZURE location for the AKS cluster | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | AZURE resource group name for the AKS cluster | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## IAM permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Policy required is:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy",
                "iam:DeletePolicy",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:ListPolicyVersions"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->
