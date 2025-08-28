resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}


