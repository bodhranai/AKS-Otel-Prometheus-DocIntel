resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.env}-${var.cluster_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "devaks1"

  kubernetes_version      = var.aks_version
  private_cluster_enabled = false
  node_resource_group     = "${var.resource_group_name}-${var.env}-${var.cluster_name}"

  # For production change to "Standard" 
  sku_tier = "Free"

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.0.64.10"
    service_cidr   = "10.0.64.0/19"
  }

  default_node_pool {
    name                 = "general"
    vm_size              = "Standard_D2_v2"
    orchestrator_version = var.aks_version
    type                 = "VirtualMachineScaleSets"
    node_count           = 1
    min_count            = 1
    max_count            = 10

    node_labels = {
      role = "general"
    }
  }

  # 🔑 Switch to System Assigned Identity
  identity {
    type = "SystemAssigned"
  }

  tags = {
    env = var.env
  }

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }
}
resource "azurerm_kubernetes_cluster_node_pool" "system" {
  name                  = "system"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.node_vm_size
  vnet_subnet_id        = var.subnet_id
  orchestrator_version  = var.aks_version

  node_count = var.node_count
  min_count  = 1
  max_count  = 10

  node_labels = {
    role                                    = "system"
    "kubernetes.azure.com/scalesetpriority" = "regular"
  }

  tags = {
    env = var.env
  }
}
