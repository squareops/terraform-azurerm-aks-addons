resource "kubernetes_storage_class_v1" "single_az_sc" {
  count = var.single_az_storage_class ? 1 : 0
  metadata {
    name = var.single_az_storage_class_name
  }
  storage_provisioner    = "kubernetes.io/azure-disk"
  reclaim_policy         = "Retain"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"
  parameters = {
    skuName       = "StandardSSD_ZRS"
  }
  allowed_topologies {
    match_label_expressions {
      key = "failure-domain.beta.kubernetes.io/zone"
      values = [
        var.zone
      ]
    }
  }
}
