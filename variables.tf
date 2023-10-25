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

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "cluster_subnet_name" {
  type    = string
  default = "Name of the subnet where AKS will be deployed."
}

variable "virtual_network_name" {
  type    = string
  default = "Name of the Virtual Network."
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