resource "kubernetes_namespace" "keda" {

  metadata {
    name = "keda"
  }
}

resource "helm_release" "keda" {
  depends_on = [kubernetes_namespace.keda]

  name              = "keda"
  repository        = "https://kedacore.github.io/charts"
  chart             = "keda"
  namespace         = "keda"
  dependency_update = true
  reset_values      = true
  atomic            = true
  replace           = true
  version           = format("%s%s", "v", var.keda_version)
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