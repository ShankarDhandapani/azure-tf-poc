# AKS cluster
resource "azurerm_kubernetes_cluster" "k8s" {
  location                   = azurerm_resource_group.resource_group.location
  name                       = var.cluster_name
  resource_group_name        = azurerm_resource_group.resource_group.name
  dns_prefix_private_cluster = var.cluster_name
  private_cluster_enabled    = true
  private_dns_zone_id        = azurerm_private_dns_zone.private_dns_zone.id
  sku_tier                   = "Standard"
  automatic_channel_upgrade  = "stable"
  tags                       = var.tags


  azure_policy_enabled             = true
  http_application_routing_enabled = true

  # https://learn.microsoft.com/en-us/azure/aks/learn/tutorial-kubernetes-workload-identity
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.aks_admin_group_object_ids
    azure_rbac_enabled     = true
  }

  default_node_pool {
    name                        = "default"
    vm_size                     = "Standard_D4s_v3"
    enable_auto_scaling         = true
    enable_host_encryption      = true
    node_count                  = var.initial_node_count
    min_count                   = var.node_count_min
    max_count                   = var.node_count_max
    max_pods                    = 30
    tags                        = var.tags
    temporary_name_for_rotation = "upgrade"
    vnet_subnet_id              = data.azurerm_subnet.cluster_subnet.id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.k8s.id]
  }

  # https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }

  network_profile {
    load_balancer_sku   = "standard"
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"

    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks.id
  }

  web_app_routing {
    dns_zone_id = ""
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
}
