output "environment" {
  description = "Environment Name for the AKS cluster"
  value       = local.environment
}

output "nginx_ingress_controller_dns_hostname" {
  description = "NGINX Ingress Controller DNS Hostname"
  value       = module.aks_addons.nginx_ingress_controller_dns_hostname
}

output "internal_nginx_ingress_controller_dns_hostname" {
  description = "NGINX Internal Ingress Controller DNS Hostname"
  value       = module.aks_addons.internal_nginx_ingress_controller_dns_hostname
}

