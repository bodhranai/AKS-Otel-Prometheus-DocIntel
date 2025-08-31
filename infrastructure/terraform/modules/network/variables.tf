
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
  default     = "10.0.0.0/16"

}

variable "vnet_name" {}
variable "address_space" {
  type = list(string)
}
variable "resource_group_name" {}
variable "subnets" {
  description = "Map of subnet_name => [address_prefixes]"
  type        = map(list(string))
}
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}