env      = "prod"
location = "westus"

# Resource group name dynamically built
resource_group_name = "rg-otel-prom-westus-prod"

tags = {
  environment = "prod"
  project     = "AKS-Otel-Prometheus-DocIntel"
}

# Networking
vnet_name      = "vnet-westus-prod"
address_space  = ["10.0.0.0/8"]
dns_service_ip = "172.16.0.10"

service_cidr = "172.16.0.0/12"

subnets = {
  aks       = ["10.240.0.0/16"]
  workloads = ["10.241.0.0/16"]
}

namespace = "ingress-nginx"

# AKS
cluster_name       = "aks-prod"
dns_prefix         = "aksprod"
kubernetes_version = "1.30.3"

# Node Pools
system_node_count   = 3
system_node_vm_size = "Standard_DS2_v2"

user_node_count   = 5
user_node_vm_size = "Standard_DS3_v2"


# Helm chart versions
nginx_version        = "4.11.0"
cert_manager_version = "v1.14.2"
