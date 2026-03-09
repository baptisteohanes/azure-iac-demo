#--------------------------------------------------------------
# Route Table
#--------------------------------------------------------------
resource "azurerm_route_table" "hub_agw" {
  name                          = "rt-hub-agw"
  resource_group_name           = azurerm_resource_group.hub_network.name
  location                      = var.location_frc
  bgp_route_propagation_enabled = false
  tags                          = {}

  route {
    name                   = "DefaultToFirewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }
}

#--------------------------------------------------------------
# Public IP Address
#--------------------------------------------------------------
resource "azurerm_public_ip" "afw_hub_data" {
  name                = "pip-afw-hub-secured-frc-data"
  resource_group_name = azurerm_resource_group.hub_network.name
  location            = var.location_frc
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  ip_version          = "IPv4"
  idle_timeout_in_minutes = 4
  zones               = ["1", "2", "3"]
}
