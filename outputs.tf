output "environment" {
  description = "Environment Name for the AKS cluster"
  value       = var.environment
}

output "nginx_ingress_controller_dns_hostname" {
  description = "NGINX Ingress Controller DNS Hostname"
  value       = var.ingress_nginx_enabled ? data.kubernetes_service.nginx-ingress.status[0].load_balancer[0].ingress[0].ip : null
}

output "internal_nginx_ingress_controller_dns_hostname" {
  description = "NGINX Internal Ingress Controller DNS Hostname"
  value       = var.internal_ingress_nginx_enabled ? data.kubernetes_service.internal-nginx-ingress.status[0].load_balancer[0].ingress[0].ip : null
}
