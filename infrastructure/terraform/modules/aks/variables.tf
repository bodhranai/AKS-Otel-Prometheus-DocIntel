variable "env" {
  # You can set a default value if needed, e.g. default = "dev"
}
variable "cluster_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "dns_prefix" {}
variable "kubernetes_version" {}
variable "service_cidr" {}
variable "dns_service_ip" {}

variable "system_node_count" {
  default = 2
}
variable "system_node_vm_size" {
  default = "Standard_DS2_v2"
}

variable "user_node_count" {
  default = 2
}
variable "user_node_vm_size" {
  default = "Standard_DS3_v2"
}

variable "subnet_ids" {
  type = map(string)
}
variable "node_count" {
  description = "Number of nodes in the user node pool"
  type        = number
  default     = 2
}