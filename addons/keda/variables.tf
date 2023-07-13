variable "keda_version" {
  default = ""
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