env      = "dev"
location = "westus"

# Resource group name dynamically built
resource_group_name = "rg-otel-prom-${lower(location)}-${env}"

tags = {
  environment = env
  project     = "AKS-Otel-Prometheus-DocIntel"
}

# VNet dynamically named
vnet_name = "vnet-otel-prom-${env}"
vnet_cidr = "10.0.0.0/16"

subnets = {
  aks = "10.0.1.0/24"
  # add more subnets if needed
}

namespace = "ingress-nginx"

# AKS cluster dynamically named
cluster_name       = "aks-otel-prom-${env}"
kubernetes_version = "1.33.2"
node_count         = 3
node_vm_size       = "Standard_DS2_v2"

# Helm chart versions
nginx_version        = "4.11.0"
cert_manager_version = "v1.14.2"
