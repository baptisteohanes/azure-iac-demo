#!/bin/bash
set -e

SUB="8c315d4c-9df6-4317-b076-ddfb4e38dd82"
RG="rg-hub-network"
BASE="/subscriptions/${SUB}/resourceGroups/${RG}"

echo "=== Importing resources into Terraform state ==="

echo "[1/15] Resource Group"
terraform import azurerm_resource_group.hub_network "${BASE}"

echo "[2/15] Virtual WAN"
terraform import azurerm_virtual_wan.hub "${BASE}/providers/Microsoft.Network/virtualWans/vwan-hub-global"

echo "[3/15] Virtual Hub - France Central"
terraform import azurerm_virtual_hub.frc "${BASE}/providers/Microsoft.Network/virtualHubs/vhub-hub-frc"

echo "[4/15] Virtual Hub - Sweden Central"
terraform import azurerm_virtual_hub.swc "${BASE}/providers/Microsoft.Network/virtualHubs/vhub-hub-swc"

echo "[5/15] VPN Site"
terraform import azurerm_vpn_site.dc_frc "${BASE}/providers/Microsoft.Network/vpnSites/vpns-hub-dc-frc"

echo "[6/15] VPN Gateway - France Central"
terraform import azurerm_vpn_gateway.frc "${BASE}/providers/Microsoft.Network/vpnGateways/0e8e282ec636443fa3f53ba9366ef55a-francecentral-gw"

echo "[7/15] VPN Gateway - Sweden Central"
terraform import azurerm_vpn_gateway.swc "${BASE}/providers/Microsoft.Network/vpnGateways/b7472f1dd8064793b3d797943faee45e-swedencentral-gw"

echo "[8/15] VPN Connection - France Central"
terraform import azurerm_vpn_gateway_connection.frc_to_dc "${BASE}/providers/Microsoft.Network/vpnGateways/0e8e282ec636443fa3f53ba9366ef55a-francecentral-gw/vpnConnections/Connection-vpns-hub-dc-frc"

echo "[9/15] VPN Connection - Sweden Central"
terraform import azurerm_vpn_gateway_connection.swc_to_dc "${BASE}/providers/Microsoft.Network/vpnGateways/b7472f1dd8064793b3d797943faee45e-swedencentral-gw/vpnConnections/Connection-vpns-hub-dc-frc"

echo "[10/15] Storage Account - France Central"
terraform import azurerm_storage_account.flowlogs_frc "${BASE}/providers/Microsoft.Storage/storageAccounts/sahubflowlogsfrc"

echo "[11/15] Storage Account - Sweden Central"
terraform import azurerm_storage_account.flowlogs_swc "${BASE}/providers/Microsoft.Storage/storageAccounts/sahubflowlogsswc"

echo "[12/15] EventGrid System Topic - France Central"
terraform import azurerm_eventgrid_system_topic.flowlogs_frc "${BASE}/providers/Microsoft.EventGrid/systemTopics/sahubflowlogsfrc-95aae5f5-3afd-4795-b741-94c97efc8dfd"

echo "[13/15] EventGrid System Topic - Sweden Central"
terraform import azurerm_eventgrid_system_topic.flowlogs_swc "${BASE}/providers/Microsoft.EventGrid/systemTopics/sahubflowlogsswc-bba2dac5-58d5-4c70-a0cf-2f59ee36b2ed"

echo "[14/15] Route Table"
terraform import azurerm_route_table.hub_agw "${BASE}/providers/Microsoft.Network/routeTables/rt-hub-agw"

echo "[15/15] Public IP"
terraform import azurerm_public_ip.afw_hub_data "${BASE}/providers/Microsoft.Network/publicIPAddresses/pip-afw-hub-secured-frc-data"

echo ""
echo "=== All 15 imports completed successfully ==="
