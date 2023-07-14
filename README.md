# AKS Add Ons
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
Terraform module to create AKS cluster resources for workload deployment on Azure Cloud.

## Usage Example
```hcl
module "aks_addons" {
  source                                        = "squareops/aks-addons/azurerm"
  environment                                   = "dev"
  name                                          = "aks-addons"
  aks_cluster_name                              = "aks-dev"
  resource_group_name                           = "aks-resource-group"
  resource_group_location                       = "eastus"
  single_az_sc_config                           = [{ name = "infra-service-sc", zone = "1" }]
  cert_manager_letsencrypt_email                = "email@example.com"
  single_az_storage_class_enabled               = true
  service_monitor_crd_enabled                   = true
  reloader_enabled                              = true
  ingress_nginx_enabled                         = true
  internal_ingress_nginx_enabled                = false
  cert_manager_enabled                          = true
  cert_manager_install_letsencrypt_http_issuers = true
  external_secrets_enabled                      = true
  keda_enabled                                  = true
  istio_enabled                                 = false
}
```
Refer [examples](https://github.com/squareops/terraform-azure-addons/tree/main/examples/complete) for more details.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.6 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.13 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | ./addons/cert-manager | n/a |
| <a name="module_external_secrets"></a> [external\_secrets](#module\_external\_secrets) | ./addons/external_secrets | n/a |
| <a name="module_ingress_nginx"></a> [ingress\_nginx](#module\_ingress\_nginx) | ./addons/ingress-nginx | n/a |
| <a name="module_istio"></a> [istio](#module\_istio) | ./addons/istio | n/a |
| <a name="module_keda"></a> [keda](#module\_keda) | ./addons/keda | n/a |
| <a name="module_reloader"></a> [reloader](#module\_reloader) | ./addons/reloader | n/a |
| <a name="module_service_monitor_crd"></a> [service\_monitor\_crd](#module\_service\_monitor\_crd) | ./addons/service_monitor_crd | n/a |
| <a name="module_single_az_sc"></a> [single\_az\_sc](#module\_single\_az\_sc) | ./addons/azure-disk-storage-class | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.cert_manager_le_http](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.internal_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.internal_nginx](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [azurerm_kubernetes_cluster.aks_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [kubernetes_service.internal-nginx-ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |
| [kubernetes_service.nginx-ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_cluster_name"></a> [aks\_cluster\_name](#input\_aks\_cluster\_name) | Fetch Cluster ID of the cluster | `string` | `""` | no |
| <a name="input_cert_manager_enabled"></a> [cert\_manager\_enabled](#input\_cert\_manager\_enabled) | Enable internal loadbalancer | `bool` | `true` | no |
| <a name="input_cert_manager_install_letsencrypt_http_issuers"></a> [cert\_manager\_install\_letsencrypt\_http\_issuers](#input\_cert\_manager\_install\_letsencrypt\_http\_issuers) | Set to true to install http issuer | `bool` | `true` | no |
| <a name="input_cert_manager_letsencrypt_email"></a> [cert\_manager\_letsencrypt\_email](#input\_cert\_manager\_letsencrypt\_email) | Enter cert manager email | `string` | `"anoushka@squareops.com"` | no |
| <a name="input_cert_manager_version"></a> [cert\_manager\_version](#input\_cert\_manager\_version) | Specify the version of cert manager | `string` | `"1.12.1"` | no |
| <a name="input_create_service_monitor_crd"></a> [create\_service\_monitor\_crd](#input\_create\_service\_monitor\_crd) | Enable Service MOnitor for metric monitoring | `bool` | `true` | no |
| <a name="input_enable_external_secrets"></a> [enable\_external\_secrets](#input\_enable\_external\_secrets) | Enable External Secrets | `bool` | `true` | no |
| <a name="input_enable_istio"></a> [enable\_istio](#input\_enable\_istio) | Enable istio for service mesh. | `bool` | `false` | no |
| <a name="input_enable_keda"></a> [enable\_keda](#input\_enable\_keda) | Enable KEDA Event-based autoscaler add-on | `bool` | `true` | no |
| <a name="input_enable_reloader"></a> [enable\_reloader](#input\_enable\_reloader) | Set true to enable reloader | `bool` | `true` | no |
| <a name="input_enable_single_az_storage_class"></a> [enable\_single\_az\_storage\_class](#input\_enable\_single\_az\_storage\_class) | Enable Single AZ storage class. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment identifier for the AKS cluster | `string` | `""` | no |
| <a name="input_ingress_nginx_enabled"></a> [ingress\_nginx\_enabled](#input\_ingress\_nginx\_enabled) | Enable Ingress Nginx for Internet Loadbalancer | `bool` | `false` | no |
| <a name="input_ingress_nginx_version"></a> [ingress\_nginx\_version](#input\_ingress\_nginx\_version) | Specify the version of the nginx ingress | `string` | `"4.7.0"` | no |
| <a name="input_internal_ingress_nginx_enabled"></a> [internal\_ingress\_nginx\_enabled](#input\_internal\_ingress\_nginx\_enabled) | Enable Ingress Nginx for Internal Loadbalancer | `bool` | `true` | no |
| <a name="input_keda_version"></a> [keda\_version](#input\_keda\_version) | KEDA Helm release evrsion | `string` | `"2.10.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Specify the name prefix of the AKS cluster resources. | `string` | `""` | no |
| <a name="input_reloader_version"></a> [reloader\_version](#input\_reloader\_version) | Reloader release version | `string` | `"1.0.27"` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of existing resource group to be used | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of existing resource group to be used | `string` | `""` | no |
| <a name="input_service_monitor_crd_enabled"></a> [service\_monitor\_crd\_enabled](#input\_service\_monitor\_crd\_enabled) | Enable or disable the installation of Custom Resource Definitions (CRDs) for Prometheus Service Monitor. | `bool` | `true` | no |
| <a name="input_single_az_sc_config"></a> [single\_az\_sc\_config](#input\_single\_az\_sc\_config) | Define the Name and regions for storage class in Key-Value pair. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment"></a> [environment](#output\_environment) | Environment Name for the AKS cluster |
| <a name="output_internall_nginx_ingress_controller_dns_hostname"></a> [internall\_nginx\_ingress\_controller\_dns\_hostname](#output\_internall\_nginx\_ingress\_controller\_dns\_hostname) | NGINX Internal Ingress Controller DNS Hostname |
| <a name="output_nginx_ingress_controller_dns_hostname"></a> [nginx\_ingress\_controller\_dns\_hostname](#output\_nginx\_ingress\_controller\_dns\_hostname) | NGINX Ingress Controller DNS Hostname |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribution & Issue Reporting

To report an issue with a project:

  1. Search to see if the issue has already been reported
  2. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Be sure to provide enough context and details so others can understand your problem.
  3. Contributing to the project can be a great way to get involved and get help. The maintainers and other contributors may be more likely to help you if you're already making contributions to the project.


## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/).

## Support Us

To support a GitHub project by liking it, you can follow these steps:

  1. Click the "Star" button On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  2. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Starring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 5 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

You can find more information about our company on this [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).

<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->
