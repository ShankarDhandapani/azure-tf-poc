# resource "azurerm_kubernetes_cluster_extension" "flux_ext" {
#   name           = join("-", [var.cluster_name, "flux", "ext"])
#   cluster_id     = azurerm_kubernetes_cluster.k8s.id
#   extension_type = "microsoft.flux"
# }

resource "azurerm_kubernetes_flux_configuration" "flux_conf" {
  name       = join("-", [var.cluster_name, "flux", "conf"])
  cluster_id = azurerm_kubernetes_cluster.k8s.id
  namespace  = "flux"

  git_repository {
    url                    = var.git_repo_url
    reference_type         = "branch"
    reference_value        = "main"
    ssh_private_key_base64 = var.ssh_private_key_base64
  }

  kustomizations {
    name = "apps"
    path = "clusters/poc-cluster"
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux_ext
  ]
}