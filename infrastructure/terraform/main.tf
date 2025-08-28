# Resource Group module
module "rg" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = local.region
}
# Network
module "network" {
  source              = "./modules/network"
  location            = var.location
  vnet_cidr           = var.vnet_cidr
  subnets             = var.subnets
  env                 = var.env
  vnet_name           = var.vnet_name
  resource_group_name = module.rg.name
}
# Variables

# AKS Cluster
 module "aks" {
  source              = "./modules/aks"
  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = module.rg.name
  vnet_cidr           = var.vnet_cidr
  node_count          = var.node_count
  node_vm_size        = "Standard_DS2_v2"
  aks_subnet_cidr     = var.subnets["aks"]
  kubernetes_version  = var.kubernetes_version
  env                 = var.env
  subnet_ids = module.network.subnet_ids

}



# Workload Identity (federated identity to AAD)
module "workload_identity" {
  source              = "./modules/workload-identity"
  resource_group_name = module.rg.name
  location            = module.rg.location
  oidc_issuer_url     = module.aks.oidc_issuer_url
}
/*
# NGINX Ingress
module "nginx" {
  source        = "./modules/nginx"
  namespace     = "ingress-nginx"
  chart_version = var.nginx_version
}


# Cert Manager
module "cert_manager" {
  source        = "./modules/certmanager"
  chart_version = "v1.13.2"
} */
