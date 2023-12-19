module "aks" {
  source = "./modules/aks"

  resource_group_name        = var.resource_group_name
  resource_group_location    = var.resource_group_location
  existing_dns_zone_name     = var.existing_dns_zone_name
  username                   = var.username
  initial_node_count         = var.initial_node_count
  node_count_min             = var.node_count_min
  node_count_max             = var.node_count_max
  tags                       = var.tags
  cluster_name               = var.cluster_name
  service_cidr               = var.service_cidr
  dns_service_ip             = var.dns_service_ip
  aks_admin_group_object_ids = var.aks_admin_group_object_ids
  virtual_network_name       = var.virtual_network_name
  virtual_network_cidr       = var.virtual_network_cidr
  identity_name              = var.identity_name
  subnets                    = var.subnets
  ssh_private_key_base64     = var.ssh_private_key_base64
  git_repo_url               = var.git_repo_url
}