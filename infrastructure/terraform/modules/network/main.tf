resource "azurerm_virtual_network" "this" {

  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  name                = var.vnet_name
  tags = {
    env = var.env
  }
}

resource "azurerm_subnet" "this" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
  depends_on           = [azurerm_virtual_network.this]
}
