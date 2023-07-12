variable "resource_group_name" {
  default = "demo-skaf-rg"
  type    = string
}
variable "cert_manager_version" {
  default = ""
  type    = string
}
variable "cert_manager_enabled" {
  default = true
  type    = bool
}
variable "cluster_name" {
  default = "demo-skaf-aks"
  type    = string
}
variable "enable_service_monitor" {
  default = true
  type    = bool
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