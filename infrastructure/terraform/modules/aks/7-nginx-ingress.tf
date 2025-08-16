############################################
# Get AKS cluster connection details
############################################
data "azurerm_kubernetes_cluster" "this" {
  name                = "${local.env}-${local.aks_name}"
  resource_group_name = local.resource_group_name

  depends_on = [azurerm_kubernetes_cluster.this]
}


# Configure the K9s provider
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Configure the HELM provider
provider "helm" {
}


############################################
# Install NGINX Ingress Controller
############################################
resource "helm_release" "external_nginx" {
  name             = "external"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  version          = "4.8.0"

  values = [file("${path.module}/values/ingress.yaml")]
}
