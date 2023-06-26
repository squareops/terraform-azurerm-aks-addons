variable "enable_service_monitor" {
  default = true
  type    = bool
}
variable "environment" {
  description = "Environment identifier for the EKS cluster"
  default     = ""
  type        = string
}
variable "name" {
  description = "Specify the name prefix of the EKS cluster resources."
  default     = ""
  type        = string
}
variable "ingress_nginx_version" {
  description = "Specify the version of the nginx ingress"
  default     = "4.1.4"
  type        = string
}
variable "ingress_nginx_enabled" {
  default = true
  type    = bool
}