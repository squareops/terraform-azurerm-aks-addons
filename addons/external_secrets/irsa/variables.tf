variable "cluster_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the cluster"
  default     = { cluster_name = "external-secrets-operator" }
}
variable "resource_group_name" {
  default = "skaf-demo-rg"
  type    = string
}
variable "resource_group_location" {
  default = "eastus"
  type    = string
}

variable "environment" {
  default     = ""
  type        = string
  description = "Environment identifier for the AKS cluster"
}

variable "name" {
  default     = ""
  type        = string
  description = "Specify the name of the resource"
}

variable "cluster_issuer_url" {
  type    = string
  default = ""
}