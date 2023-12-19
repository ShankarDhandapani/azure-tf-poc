locals {
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.resource_group.name
}

data "azurerm_client_config" "current" {}

data "azurerm_virtual_network" "vnet_data" {
  name                = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name
}

data "azurerm_subnet" "cluster_subnet" {
  name                 = data.azurerm_virtual_network.vnet_data.subnets[0]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
}