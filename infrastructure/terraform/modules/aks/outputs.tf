output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "subnet_id" {
  value = azurerm_subnet.aks_subnet.id
}
