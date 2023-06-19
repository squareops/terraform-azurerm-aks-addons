# OPEN: Default label needs to be removed from gp2 storageclass in order to make gp3 as default choice for EBS volume provisioning.
# module "single_az_sc" {
#   for_each                             = { for sc in var.single_az_sc_config : sc.name => sc }
#   source                               = "./addons/aws-ebs-storage-class"
#   single_az_ebs_gp3_storage_class      = var.enable_single_az_ebs_gp3_storage_class
#   single_az_ebs_gp3_storage_class_name = each.value.name
#   kms_key_id                           = var.kms_key_arn
#   availability_zone                    = each.value.zone
# }

data "azurerm_kubernetes_cluster" "aks_cluster" {
  name = var.cluster_name
  resource_group_name = var.resource_group_name
}

# resource "null_resource" "get_kubeconfig" {

#   provisioner "local-exec" {
#     command = "az aks get-credentials --resource-group ${var.resource_group_name} --name ${var.cluster_name} --admin --overwrite-existing"
#   }
# }

module "ingress_nginx" {
  source                 = "./addons/ingress-nginx"
  count                  = var.ingress_nginx_enabled ? 1 : 0
  environment            = var.environment
  name                   = var.name
  enable_service_monitor = var.create_service_monitor_crd
  ingress_nginx_version  = var.ingress_nginx_version
}

module "cert_manager" {
  source                         = "./addons/cert-manager"
  count                          = var.cert_manager_enabled ? 1 : 0
  environment                    = var.environment
  name                           = var.name
  enable_service_monitor         = var.create_service_monitor_crd
  cert_manager_version           = var.cert_manager_version
  cert_manager_letsencrypt_email = var.cert_manager_letsencrypt_email
}

module "external_secrets" {
  source = "./addons/external_secrets"
  count  = var.enable_external_secrets ? 1 : 0

  environment             = var.environment
  name                    = var.name
  resource_group_location = var.resource_group_location
  resource_group_name     = var.resource_group_name
  enable_service_monitor  = var.create_service_monitor_crd
  cluster_issuer_url      = data.azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
}

module "istio" {
  source = "./addons/istio"
  count  = var.enable_istio ? 1 : 0
}

# module "karpenter_provisioner" {
#   source                               = "./addons/karpenter_provisioner"

#   count                                = var.enable_karpenter ? 1 : 0
#   subnet_selector_name                 = var.private_subnet_name
#   sg_selector_name                     = var.eks_cluster_name
#   karpenter_ec2_capacity_type          = var.karpenter_ec2_capacity_type
#   excluded_karpenter_ec2_instance_type = var.excluded_karpenter_ec2_instance_type
# }


# ### EFS
# module "efs" {
#   source             = "./addons/efs"
#   depends_on         = [module.k8s_addons]
#   count              = var.create_efs_storage_class ? 1 : 0
#   environment        = var.environment
#   vpc_id             = var.vpc_id
#   private_subnet_ids = var.private_subnet_ids
#   region             = data.aws_region.current.name
#   name               = var.name
#   kms_key_id         = var.kms_key_arn
# }

# data "kubernetes_service" "nginx-ingress" {
#   depends_on = [module.k8s_addons]
#   metadata {
#     name      = "ingress-nginx-controller"
#     namespace = "ingress-nginx"
#   }
# }