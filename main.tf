resource "azurerm_resource_group" "hub_network" {
  name     = var.resource_group_name
  location = var.location_frc
}
