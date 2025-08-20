
############################################
# Install NGINX Ingress Controller
############################################
resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = var.namespace
  version          = var.chart_version
  create_namespace = true
}

