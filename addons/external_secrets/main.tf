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
  repository = "https://external-secrets.github.io/kubernetes-external-secrets/"
  chart      = "kubernetes-external-secrets"
  namespace  = "secrets"
  timeout    = 600
  version    = "8.5.5"

  values = [
    templatefile("${path.module}/values.yaml", {
      enable_service_monitor = var.enable_service_monitor
    })
  ]

  # set {
  #   name  = "env.AWS_REGION"
  #   value = var.region
  # }

  set {
    name  = "serviceAccount.annotations.azure\\.workload\\.identity/client-id"
    value = module.irsa.service_principal_application_id
  }
  set {
    name  = "serviceAccount.annottaions.azure\\.workload\\.identity/tenant-id"
    value = data.azurerm_client_config.current.tenant_id
  }
}
