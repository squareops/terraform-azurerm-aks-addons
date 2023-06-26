resource "null_resource" "get_kubeconfig" {

  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${var.resource_group_name} --name ${var.aks_cluster_name} --admin --overwrite-existing"
  }
}

module "service_monitor_crd" {
  source = "./addons/service_monitor_crd"
  count  = var.service_monitor_crd_enabled ? 1 : 0
}

module "single_az_sc" {
  for_each                     = { for sc in var.single_az_sc_config : sc.name => sc }
  source                       = "./addons/azure-disk-storage-class"
  depends_on                   = [module.service_monitor_crd, null_resource.get_kubeconfig]
  single_az_storage_class      = var.enable_single_az_storage_class
  single_az_storage_class_name = each.value.name
  zone                         = each.value.zone
}

data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  resource_group_name = var.resource_group_name
}

module "ingress_nginx" {
  source                 = "./addons/ingress-nginx"
  depends_on             = [module.service_monitor_crd, null_resource.get_kubeconfig]
  count                  = var.enable_ingress_nginx ? 1 : 0
  environment            = var.environment
  name                   = var.name
  enable_service_monitor = var.service_monitor_crd_enabled
  ingress_nginx_version  = var.ingress_nginx_version
}

data "kubernetes_service" "nginx-ingress" {
  depends_on = [module.service_monitor_crd, null_resource.get_kubeconfig]
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }
}

resource "kubernetes_namespace" "internal_nginx" {
  count      = var.enable_internal_ingress_nginx ? 1 : 0
  depends_on = [module.service_monitor_crd, null_resource.get_kubeconfig]
  metadata {
    name = "internal-ingress-nginx"
  }
}

resource "helm_release" "internal_nginx" {
  depends_on = [module.service_monitor_crd, null_resource.get_kubeconfig]
  count      = var.enable_internal_ingress_nginx ? 1 : 0
  name       = "internal-ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.7.0"
  namespace  = "internal-ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  values = [
    templatefile("${path.module}/addons/internal_ingress_nginx/values.yaml", {
      enable_service_monitor = var.service_monitor_crd_enabled
    })
  ]
}

data "kubernetes_service" "internal-nginx-ingress" {
  depends_on = [module.service_monitor_crd, null_resource.get_kubeconfig]
  metadata {
    name      = "internal-ingress-nginx-controller"
    namespace = "internal-ingress-nginx"
  }
}

module "cert_manager" {
  source                 = "./addons/cert-manager"
  depends_on             = [module.service_monitor_crd, null_resource.get_kubeconfig]
  count                  = var.cert_manager_enabled ? 1 : 0
  environment            = var.environment
  name                   = var.name
  enable_service_monitor = var.service_monitor_crd_enabled
  cert_manager_version   = var.cert_manager_version
}

resource "helm_release" "cert_manager_le_http" {
  depends_on = [module.service_monitor_crd, null_resource.get_kubeconfig]
  count      = var.cert_manager_install_letsencrypt_http_issuers ? 1 : 0
  name       = "cert-manager-le-http"
  chart      = "${path.module}/addons/cert-manager-le-http"
  version    = "0.1.0"
  set {
    name  = "email"
    value = var.cert_manager_letsencrypt_email
    type  = "string"
  }
}

module "external_secrets" {
  source     = "./addons/external_secrets"
  depends_on = [module.service_monitor_crd, null_resource.get_kubeconfig]
  count      = var.enable_external_secrets ? 1 : 0

  environment             = var.environment
  name                    = var.name
  resource_group_location = var.resource_group_location
  resource_group_name     = var.resource_group_name
  enable_service_monitor  = var.service_monitor_crd_enabled
  cluster_issuer_url      = data.azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
}

module "istio" {
  source     = "./addons/istio"
  depends_on = [module.service_monitor_crd, null_resource.get_kubeconfig]
  count      = var.enable_istio ? 1 : 0
}

module "reloader" {
  source                 = "./addons/reloader"
  depends_on             = [module.service_monitor_crd, null_resource.get_kubeconfig]
  count                  = var.enable_reloader ? 1 : 0
  reloader_version       = var.reloader_version
  enable_service_monitor = var.service_monitor_crd_enabled
}

module "keda" {
  source                 = "./addons/keda"
  depends_on             = [module.service_monitor_crd, null_resource.get_kubeconfig]
  count                  = var.enable_keda ? 1 : 0
  environment            = var.environment
  name                   = var.name
  enable_service_monitor = var.service_monitor_crd_enabled
  keda_version           = var.keda_version
}