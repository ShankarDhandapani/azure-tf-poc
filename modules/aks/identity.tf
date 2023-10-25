# AKS identity
# We provision the user-assigned identity as well as role assignments necessary
# for BYO DNS and creation of resources in existing resource group.
resource "azurerm_user_assigned_identity" "k8s" {
  name                = var.identity_name
  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.resource_group.location
  tags                = var.tags
}

# moved {
#   from = azurerm_user_assigned_identity.example
#   to   = azurerm_user_assigned_identity.k8s
# }

resource "azurerm_role_assignment" "k8s_main" {
  scope                = data.azurerm_resource_group.resource_group.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.k8s.principal_id
}