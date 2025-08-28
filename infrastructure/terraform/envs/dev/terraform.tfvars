env                 = "dev"
location            = "eastus2"
resource_group_name = "rg-otel-prom-dev"
tags = {
  environment = "dev"
  project     = "AKS-Otel-Prometheus-DocIntel"
}

vnet_name = "vnet-otel-prom-dev"
vnet_cidr = "10.0.0.0/16" # <-- Replace with your actual VNet CIDR
subnets = {
  aks = "10.0.1.0/24" # <-- Replace/add subnets as needed
}
namespace = "ingress-nginx" # <-- Replace with your actual namespace

cluster_name       = "aks-otel-prom-dev"
kubernetes_version = "1.33.4"
node_count         = 3
node_vm_size       = "Standard_DS2_v2"

nginx_version        = "4.11.0"
cert_manager_version = "v1.14.2"
