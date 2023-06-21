data "azurerm_client_config" "current" {}

resource "kubernetes_namespace" "external_secrets" {

  metadata {
    name = "secrets"
  }
}

module "irsa" {
  source                  = "./irsa"
  depends_on              = [kubernetes_namespace.external_secrets]
  resource_group_location = var.resource_group_location
  resource_group_name     = var.resource_group_name
  cluster_issuer_url      = var.cluster_issuer_url
  name                    = var.name
  environment             = var.environment
}

resource "helm_release" "external_secrets" {
  depends_on = [module.irsa]

  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  namespace  = "secrets"
  timeout    = 600
  version    = "0.8.3"

  values = [
    templatefile("${path.module}/values.yaml", {
      tenant_id = data.azurerm_client_config.current.tenant_id,
      client_id = module.irsa.service_principal_application_id,
      enable_service_monitor         = var.enable_service_monitor

    })
  ]
}
