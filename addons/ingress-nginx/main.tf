resource "kubernetes_namespace" "ingress_nginx" {

  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress_nginx_controller" {
  count      = var.ingress_nginx_enabled ? 1 : 0
  depends_on = [kubernetes_namespace.ingress_nginx]

  name              = "ingress-nginx-controller"
  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  namespace         = "ingress-nginx"
  dependency_update = true
  reset_values      = true
  atomic            = true
  replace           = true
  version           = var.ingress_nginx_version
  timeout           = 600

  values = [
    templatefile("${path.module}/values.yaml", {
      enable_service_monitor = var.enable_service_monitor

    })
  ]
  lifecycle {
    create_before_destroy = true
  }
}