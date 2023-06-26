variable "cluster_id" {
  default     = ""
  type        = string
  description = "Fetch ID of the cluster"
}

variable "environment" {
  default     = ""
  type        = string
  description = "Environment identifier for the EKS cluster"
}

variable "name" {
  default     = ""
  type        = string
  description = "Specify the name of the resource"
}

variable "provider_url" {
  default = ""
  type    = string
}

variable "resource_group_location" {
  default     = ""
  type        = string
  description = "AZURE location for the AKS cluster"
}

variable "resource_group_name" {
  default     = ""
  type        = string
  description = "AZURE resource group name for the AKS cluster"
}

variable "enable_service_monitor" {
  type        = bool
  default     = false
  description = "(optional) describe your variable"
}

variable "cluster_issuer_url" {
  type    = string
  default = ""
}
