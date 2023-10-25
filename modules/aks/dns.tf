# Private DNS Zone 
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "privatelink.${data.azurerm_resource_group.resource_group.location}.azmk8s.io"
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "k8s_dns" {
  scope                = azurerm_private_dns_zone.private_dns_zone.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.k8s.principal_id
}