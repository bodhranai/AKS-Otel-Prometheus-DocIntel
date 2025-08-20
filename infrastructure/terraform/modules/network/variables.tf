
variable "env" {
  description = "environment (e.g., dev, prod)"
  type        = string
}
variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for the Virtual Network."
  type        = string
  default =  "10.0.0.0/16"
  
}

variable "subnets" {
  description = "Map of subnet names and CIDR ranges"
  type = map(string)
  default = {
    aks       = "10.0.1.0/24"
    workloads = "10.0.2.0/24"
    db        = "10.0.3.0/24"
  }
}

variable "vnet_name" {
  description = "Name of the vnet."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool."
  type        = number
  default     = 1
}