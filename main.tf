module "aks" {
  source = "./modules/aks"

  resource_group_name        = var.resource_group_name
  existing_dns_zone_name     = var.existing_dns_zone_name
  username                   = var.username
  initial_node_count         = var.initial_node_count
  node_count_min             = var.node_count_min
  node_count_max             = var.node_count_max
  tags                       = var.tags
  cluster_name               = var.cluster_name
  aks_admin_group_object_ids = var.aks_admin_group_object_ids
  virtual_network_name       = var.virtual_network_name
  cluster_subnet_name        = var.cluster_subnet_name
  identity_name              = var.identity_name
}