variable "namespace" {
  description = "Namespace for ingress-nginx"
  type        = string
}

variable "chart_version" {
  description = "Helm chart version for ingress-nginx"
  type        = string
}
