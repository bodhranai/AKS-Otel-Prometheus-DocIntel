resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.env}-${var.cluster_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.env}-aks"

  # Optional: omit to use latest GA version
  kubernetes_version      = var.kubernetes_version
  private_cluster_enabled = false
  node_resource_group     = "${var.resource_group_name}-${var.env}-${var.cluster_name}"

  # For production change to "Standard" 
  sku_tier = "Free"

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    dns_service_ip     = "10.2.0.10"
    service_cidr       = var.service_cidr #"10.2.0.0/24"
  }

   default_node_pool {
    name       = "systempool"
    node_count = var.system_node_count
    vm_size    = var.system_node_vm_size
    vnet_subnet_id = var.subnet_ids["aks"]
    type       = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type" = "system"
    }
    only_critical_addons_enabled = true
  }
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

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "general"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.user_node_vm_size
  vnet_subnet_id        = var.subnet_ids["aks"]
  node_count            = var.node_count
  min_count             = 1
  max_count             = 10
  mode                  = "User"

  node_labels = {
    role                                    = "general"
    "kubernetes.azure.com/scalesetpriority" = "regular"
    "nodepool-type" = "user"
  }

  orchestrator_version = var.kubernetes_version

  tags = {
    env = var.env
  }
}

# --------------------
# CIDR overlap check
# --------------------
data "azurerm_subnet" "aks" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

resource "null_resource" "validate_cidr" {
  lifecycle {
    precondition {
      condition = !(cidrhost(var.service_cidr, 1) == cidrhost(data.azurerm_subnet.aks.address_prefixes[0], 1))
      error_message = "❌ service_cidr (${var.service_cidr}) overlaps with AKS subnet (${data.azurerm_subnet.aks.address_prefixes[0]}). Please pick a non-overlapping range."
    }
  }
}
