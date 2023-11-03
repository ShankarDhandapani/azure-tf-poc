resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = var.virtual_network_cidr

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name           = subnet.key
      address_prefix = subnet.value.address_prefix
    }
  }

  tags = var.tags
}