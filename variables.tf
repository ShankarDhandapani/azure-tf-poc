variable "subscription_id" {
  type        = string
  description = "Subscription ID for azure account"
}

variable "cluster_name" {
  type        = string
  description = "Name of AKS cluster"
}

variable "aks_admin_group_object_ids" {
  type        = list(string)
  description = "List of group object IDs which receive K8s administrative access."
}

variable "service_cidr" {
  description = "AKS Service CIDR"
  type        = string
}

variable "dns_service_ip" {
  description = "AKS DNS service ip"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "existing_resource_group_name" {
  type        = string
  description = "Existing Resource group name"
}

variable "resource_group_location" {
  type        = string
  description = "Location for New resource group to be deployed."
}

variable "virtual_network_name" {
  description = "Name of the Azure Virtual Network"
  type        = string
}

variable "virtual_network_cidr" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnets to create within the Virtual Network"
  type = map(object({
    address_prefix = string
  }))
}

variable "identity_name" {
  type        = string
  description = "Name of user-assigned identity for AKS cluster."
}

variable "existing_dns_zone_name" {
  type        = string
  description = "Name of the existing private Azure DNS zone."
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
}

variable "initial_node_count" {
  type        = number
  description = "The initial quantity of nodes for the default node pool."
}

variable "node_count_min" {
  type        = number
  description = "The minimum quantity of nodes for the default node pool."
}

variable "node_count_max" {
  type        = number
  description = "The maximum quantity of nodes for the default node pool."
}

variable "tags" {
  type        = map(string)
  description = "Tags for all resources"
}

variable "ssh_private_key_base64" {
  description = "Base64 encoded SSH private key"
  type        = string
  sensitive   = true
}

variable "git_repo_url" {
  type        = string
  description = "Name of user-assigned identity for AKS cluster."
}

variable "bastion_username" {
  type        = string
  description = "Bastion Username"
}

variable "bastion_password" {
  type        = string
  description = "Bastion password"
}