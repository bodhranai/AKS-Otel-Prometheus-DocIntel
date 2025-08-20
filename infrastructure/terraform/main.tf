
# Network
module "network" {
  source              = "./modules/network"
  location            = var.location
  vnet_cidr           = var.vnet_cidr
  subnets             = var.subnets
  env                 = var.env
  vnet_name           = var.vnet_name
  resource_group_name = var.resource_group_name
}
# Variables

# AKS Cluster
module "aks" {
  source              = "./modules/aks"
  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  vnet_subnet_id      = module.network.subnet_ids["aks"]
  vnet_cidr           = var.vnet_cidr
  node_count          = var.node_count
  node_vm_size        = "Standard_DS2_v2"
  aks_subnet_cidr     = var.subnets["aks"]
  aks_version         = var.kubernetes_version
  env                 = var.env
  enable_oidc_issuer  = true
  workload_identity   = true
}

# Extra Node Pool
module "nodepool" {
  source              = "./modules/nodepool"
  name                = "systempool"
  vm_size             = "Standard_DS2_v2"
  node_count          = 2
  node_vm_size        = "Standard_DS2_v2"
  aks_subnet_cidr     = var.subnets["aks"]
  vnet_cidr           = var.vnet_cidr
  aks_version         = var.kubernetes_version
  cluster_name        = var.cluster_name
  location            = var.location
  env                 = var.env
  resource_group_name = var.resource_group_name
}

# Workload Identity (federated identity to AAD)
module "workload_identity" {
  source              = "./modules/workload-identity"
}

# NGINX Ingress
module "nginx" {
  source    = "./modules/nginx"
  namespace = "ingress-nginx"
  chart_version = var.nginx_version
}


# Cert Manager
module "cert_manager" {
  source        = "./modules/certmanager"
  chart_version = "v1.13.2"
}
