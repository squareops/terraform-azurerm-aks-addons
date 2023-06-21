data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {}

module "service_principal" {
  source = "./service-principal"

  application_display_name = format("%s-%s-external-secrets", var.environment, var.name)
  application_owners       = [data.azurerm_client_config.current.object_id]
  issuer                   = var.cluster_issuer_url
  subject                  = "system:serviceaccount:secrets:external-secrets"
}

module "key_vault" {
  source = "./key-vault"

  key_vault_display_name  = format("%s-%s-exsecrets", var.environment, var.name)
  resource_group_location = var.resource_group_location
  resource_group_name     = var.resource_group_name
  tenant_id               = data.azurerm_client_config.current.tenant_id
  client_object_id        = data.azurerm_client_config.current.object_id
  eso_sp_object_id        = module.service_principal.sp_object_id
}

module "test_workload_identity" {
  source = "./workload-identity"

  tenant_id = data.azurerm_client_config.current.tenant_id
  tags      = var.cluster_tags

}

resource "azurerm_role_assignment" "current" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Reader"
  principal_id         = module.service_principal.sp_id
}