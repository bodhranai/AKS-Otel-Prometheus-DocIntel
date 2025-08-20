env                  = "prod"
location             = "eastus2"
resource_group_name  = "rg-otel-prom-prod"
tags = {
    environment = "prod"
    project     = "AKS-Otel-Prometheus-DocIntel"
}

vnet_name            = "vnet-otel-prom-prod"
vnet_cidr            = "10.0.0.0/16"           # <-- Replace with your actual VNet CIDR
subnet_id            = ""                      # <-- Replace with your actual subnet ID
subnets = {
    aks = "10.0.1.0/24"                         # <-- Replace/add subnets as needed
}
namespace            = "ingress-nginx"         # <-- Replace with your actual namespace

cluster_name         = "aks-otel-prom-prod"
kubernetes_version   = "1.27.3"
node_count           = 3
node_vm_size         = "Standard_DS2_v2"

nginx_version        = "4.11.0"
cert_manager_version = "v1.14.2"