locals {
  region      = "eastus"
  environment = "production"
  name        = "skaf"
  additional_tags = {
    Owner      = "SquareOps"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "aks_bootstrap" {
  source                                        = "git::https://github.com/sq-ia/terraform-azure-aks-bootstrap.git?ref=release/v1"
  environment                                   = ""
  name                                          = ""
  aks_cluster_name                              = ""
  resource_group_name                           = ""
  resource_group_location                       = ""
  single_az_sc_config                           = [{ name = "infra-service-sc", zone = "us-east-2a" }]
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
