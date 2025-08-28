variable "env" {
  description = "environment (e.g., dev, prod)"
  type        = string
}


variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}
variable "kubernetes_version" {
  description = "AKS version"
  type        = string
}
variable "location" {
  description = "Azure region for AKS and networking"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where AKS and networking will be deployed"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for the Virtual Network"
  type        = string
}
variable "subnet_id" {
  description = "Subnet Id for the AKS cluster"
  type        = string
}

variable "aks_subnet_cidr" {
  description = "CIDR block for the AKS subnet"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "node_vm_size" {
  description = "VM size for the default node pool"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
