output "resource_group_id" {
  description = "ID of the hub network resource group"
  value       = azurerm_resource_group.hub_network.id
}

output "virtual_wan_id" {
  description = "ID of the Virtual WAN"
  value       = azurerm_virtual_wan.hub.id
}

output "virtual_hub_frc_id" {
  description = "ID of the France Central Virtual Hub"
  value       = azurerm_virtual_hub.frc.id
}

output "virtual_hub_swc_id" {
  description = "ID of the Sweden Central Virtual Hub"
  value       = azurerm_virtual_hub.swc.id
}

output "vpn_gateway_frc_id" {
  description = "ID of the France Central VPN Gateway"
  value       = azurerm_vpn_gateway.frc.id
}

output "vpn_gateway_swc_id" {
  description = "ID of the Sweden Central VPN Gateway"
  value       = azurerm_vpn_gateway.swc.id
}

output "storage_account_frc_id" {
  description = "ID of the France Central flow logs storage account"
  value       = azurerm_storage_account.flowlogs_frc.id
}

output "storage_account_swc_id" {
  description = "ID of the Sweden Central flow logs storage account"
  value       = azurerm_storage_account.flowlogs_swc.id
}
