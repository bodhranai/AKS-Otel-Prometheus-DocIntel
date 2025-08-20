resource "azurerm_virtual_network" "this" {

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet_cidr]
  name                = var.vnet_name
  tags = {
    env = var.env
  }
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
}

output "subnet_ids" {
  value = { for k, v in azurerm_subnet.this : k => v.id }
}
