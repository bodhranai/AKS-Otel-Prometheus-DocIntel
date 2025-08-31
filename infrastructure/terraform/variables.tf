############################################
# Global
############################################
variable "env" {
  description = "Environment (e.g., dev, prod)"
  type        = string
  default     = "prod"
}
variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group for all resources"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

############################################
# Network
############################################
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}
variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "vnet_cidr" {
  description = "Address space for the VNet"
  type        = string
}
variable "service_cidr" {
  description = "Service CIDR for the AKS cluster"
  type        = string
}
variable "subnets" {
  description = "Map of subnet_name => [address_prefixes]"
  type        = map(list(string))
}
variable "dns_prefix" {}
variable "namespace" {
  description = "Ingress Namespace"
  type        = string
}
############################################
# AKS
############################################
variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
  default     = "1.29.2"
}

variable "node_count" {
  description = "Default node count for the AKS system pool"
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

############################################
# Add-ons (Helm modules)
############################################
variable "nginx_version" {
  description = "Helm chart version for ingress-nginx"
  type        = string
  default     = "4.11.0"
}

variable "cert_manager_version" {
  description = "Helm chart version for cert-manager"
  type        = string
  default     = "v1.14.2"
}
