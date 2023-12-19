# https://learn.microsoft.com/en-us/azure/aks/azure-disk-customer-managed-keys
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set
resource "azurerm_key_vault" "aks" {
  name                        = join("-", [var.cluster_name, "vault"])
  location                    = azurerm_resource_group.resource_group.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "premium"
  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
  tags                        = var.tags
}

resource "azurerm_key_vault_access_policy" "aks_user_policy" {
  key_vault_id = azurerm_key_vault.aks.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "GetRotationPolicy",
    "SetRotationPolicy",
    "WrapKey",
    "UnwrapKey",
  ]
}

resource "azurerm_key_vault_key" "aks" {
  name         = join("-", [var.cluster_name, "key"])
  key_vault_id = azurerm_key_vault.aks.id
  key_type     = "RSA"
  key_size     = 2048
  tags         = var.tags

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey"
  ]
}

resource "azurerm_disk_encryption_set" "aks" {
  name                = join("-", [var.cluster_name, "des"])
  resource_group_name = var.resource_group_name
  location            = azurerm_resource_group.resource_group.location
  key_vault_key_id    = azurerm_key_vault_key.aks.id
  tags                = var.tags

  identity {
    type = "SystemAssigned"
  }
}

# resource "azurerm_key_vault_access_policy" "aks_encryption_policy" {
#   key_vault_id = azurerm_key_vault.aks.id
#   tenant_id    = azurerm_disk_encryption_set.aks.identity.0.tenant_id
#   object_id    = azurerm_disk_encryption_set.aks.identity.0.principal_id

#   key_permissions = [
#     "Get",
#     "WrapKey",
#     "UnwrapKey",
#     "GetRotationPolicy"
#   ]
# }
