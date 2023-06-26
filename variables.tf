variable "resource_group_name" {
  description = "Name of existing resource group to be used"
  default     = ""
  type        = string
}
variable "resource_group_location" {
  description = "Location of existing resource group to be used"
  default     = ""
  type        = string
}
variable "environment" {
  description = "Environment identifier for the AKS cluster"
  default     = ""
  type        = string
}
variable "name" {
  description = "Specify the name prefix of the AKS cluster resources."
  default     = ""
  type        = string
}
variable "aks_cluster_name" {
  description = "Fetch Cluster ID of the cluster"
  type        = string
  default     = ""
}
variable "enable_keda" {
  description = "Enable KEDA Event-based autoscaler add-on"
  type        = bool
  default     = false
}
variable "keda_version" {
  description = "KEDA Helm release evrsion"
  default     = "2.10.2"
  type        = string
}
variable "cert_manager_version" {
  description = "Specify the version of cert manager"
  default     = "1.12.1"
  type        = string
}
variable "cert_manager_enabled" {
  description = "Enable internal loadbalancer"
  default     = false
  type        = bool
}
variable "cert_manager_letsencrypt_email" {
  description = "Enter cert manager email"
  default     = "anoushka@squareops.com"
  type        = string
}
variable "ingress_nginx_version" {
  description = "Specify the version of the nginx ingress"
  default     = "4.7.0"
  type        = string
}
variable "enable_ingress_nginx" {
  description = "Enable Ingress Nginx for Internet Loadbalancer"
  default     = false
  type        = bool
}
variable "enable_internal_ingress_nginx" {
  description = "Enable Ingress Nginx for Internal Loadbalancer"
  default     = false
  type        = bool
}
variable "enable_external_secrets" {
  description = "Enable External Secrets"
  default     = false
  type        = bool
}
variable "enable_istio" {
  description = "Enable istio for service mesh."
  default     = false
  type        = bool
}
variable "enable_single_az_storage_class" {
  description = "Enable Single AZ storage class."
  default     = false
  type        = bool
}
variable "single_az_sc_config" {
  description = "Define the Name and regions for storage class in Key-Value pair."
  default     = []
  type        = list(any)
}
variable "service_monitor_crd_enabled" {
  description = "Enable or disable the installation of Custom Resource Definitions (CRDs) for Prometheus Service Monitor. "
  default     = false
  type        = bool
}
variable "cert_manager_install_letsencrypt_http_issuers" {
  description = "Set to true to install http issuer"
  default     = false
  type        = bool
}
variable "enable_reloader" {
  description = "Set true to enable reloader"
  default     = false
  type        = bool
}
variable "reloader_version" {
  description = "Reloader release version"
  default     = "1.0.27"
  type        = string
}