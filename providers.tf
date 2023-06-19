provider "azurerm" {
  features {}
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# provider "helm" {
#   alias = "aks-module"
#   kubernetes {
#     host                   = module.aks.aks_kube_config[0].host
#     client_certificate     = base64decode(module.aks.aks_kube_config[0].client_certificate)
#     client_key             = base64decode(module.aks.aks_kube_config[0].client_key)
#     cluster_ca_certificate = base64decode(module.aks.aks_kube_config[0].cluster_ca_certificate)
#   }
# }