# AKS logging
# Provision the Log Analytics workspace as well as Log Analytics solution (formerly Operational Insights).
resource "random_id" "workspace" {
  byte_length = 4
}

resource "azurerm_log_analytics_workspace" "aks" {
  name                = "${var.cluster_name}-logs-${random_id.workspace.hex}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  tags                = var.tags
}

resource "azurerm_log_analytics_solution" "aks" {
  location              = data.azurerm_resource_group.resource_group.location
  resource_group_name   = var.resource_group_name
  solution_name         = "ContainerInsights"
  workspace_name        = azurerm_log_analytics_workspace.aks.name
  workspace_resource_id = azurerm_log_analytics_workspace.aks.id
  tags                  = var.tags

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}