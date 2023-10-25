variable "cluster_name" {
  type        = string
  description = "Name of AKS cluster"
}

variable "tags" {
  type        = map(string)
  description = "Tags for all resources"
}

variable "resource_group_name" {
  type        = string
  description = "Existing resource group that will contain resources to be deployed."
}

variable "aks_admin_group_object_ids" {
  type        = list(string)
  description = "List of group object IDs which receive K8s administrative access."
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

variable "cluster_subnet_name" {
  type    = string
  default = "Name of the subnet where AKS will be deployed."
}

variable "virtual_network_name" {
  type    = string
  default = "Name of the Virtual Network."
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
}

variable "existing_dns_zone_name" {
  type        = string
  description = "Name of the existing private Azure DNS zone."
}

variable "identity_name" {
  type        = string
  description = "Name of user-assigned identity for AKS cluster."
}

# variable "msi_id" {
#   type        = string
#   description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
#   default     = null
# }
