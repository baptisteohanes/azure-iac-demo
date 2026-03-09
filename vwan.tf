#--------------------------------------------------------------
# Virtual WAN
#--------------------------------------------------------------
resource "azurerm_virtual_wan" "hub" {
  name                           = "vwan-hub-global"
  resource_group_name            = azurerm_resource_group.hub_network.name
  location                       = azurerm_resource_group.hub_network.location
  allow_branch_to_branch_traffic = true
  type                           = "Standard"
}

#--------------------------------------------------------------
# Virtual Hubs
#--------------------------------------------------------------
resource "azurerm_virtual_hub" "frc" {
  name                   = "vhub-hub-frc"
  resource_group_name    = azurerm_resource_group.hub_network.name
  location               = var.location_frc
  virtual_wan_id         = azurerm_virtual_wan.hub.id
  address_prefix         = var.vwan_address_prefix_frc
  sku                    = "Standard"
  hub_routing_preference = "ASPath"
  tags                   = {}
}

resource "azurerm_virtual_hub" "swc" {
  name                   = "vhub-hub-swc"
  resource_group_name    = azurerm_resource_group.hub_network.name
  location               = var.location_swc
  virtual_wan_id         = azurerm_virtual_wan.hub.id
  address_prefix         = var.vwan_address_prefix_swc
  sku                    = "Standard"
  hub_routing_preference = "ASPath"
  tags                   = {}
}
