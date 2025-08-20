# modules/aks/outputs.tf
output "kube_config" {
  description = "Kube config for AKS"
  value = {
    host                   = azurerm_kubernetes_cluster.this.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.this.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
  }
  sensitive = true
}
output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.this.oidc_issuer_url
}


