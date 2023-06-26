locals {
  region      = "us-east-2"
  environment = "production"
  name        = "skaf"
  additional_tags = {
    Owner      = "SquareOps"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "eks_bootstrap" {
  source                                        = "../../"
  environment                                   = ""
  name                                          = ""
  aks_cluster_name                              = ""
  resource_group_name                           = ""
  resource_group_location                       = ""
  single_az_sc_config                           = [{ name = "infra-service-sc", zone = "us-east-2a" }]
  cert_manager_letsencrypt_email                = "email@example.com"
  enable_single_az_storage_class                = true
  service_monitor_crd_enabled                   = true
  enable_reloader                               = true
  enable_ingress_nginx                          = true
  enable_internal_ingress_nginx                 = false
  cert_manager_enabled                          = true
  cert_manager_install_letsencrypt_http_issuers = true
  enable_external_secrets                       = true
  enable_keda                                   = true
  enable_istio                                  = false
}
