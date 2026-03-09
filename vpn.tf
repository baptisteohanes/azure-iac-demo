#--------------------------------------------------------------
# VPN Site (on-premises datacenter)
#--------------------------------------------------------------
resource "azurerm_vpn_site" "dc_frc" {
  name                = "vpns-hub-dc-frc"
  resource_group_name = azurerm_resource_group.hub_network.name
  location            = var.location_frc
  virtual_wan_id      = azurerm_virtual_wan.hub.id

  device_vendor = "Microsoft"

  link {
    name          = "PrimaryVpnGateway"
    ip_address    = var.vpn_site_primary_ip
    speed_in_mbps = var.vpn_link_speed_mbps
    provider_name = var.vpn_link_provider

    bgp {
      asn             = var.vpn_site_bgp_asn
      peering_address = var.vpn_site_primary_bgp_address
    }
  }

  link {
    name          = "SecondaryVpnGateway"
    ip_address    = var.vpn_site_secondary_ip
    speed_in_mbps = var.vpn_link_speed_mbps
    provider_name = var.vpn_link_provider

    bgp {
      asn             = var.vpn_site_bgp_asn
      peering_address = var.vpn_site_secondary_bgp_address
    }
  }
}

#--------------------------------------------------------------
# VPN Gateways (one per Virtual Hub)
#--------------------------------------------------------------
resource "azurerm_vpn_gateway" "frc" {
  name                = "0e8e282ec636443fa3f53ba9366ef55a-francecentral-gw"
  resource_group_name = azurerm_resource_group.hub_network.name
  location            = var.location_frc
  virtual_hub_id      = azurerm_virtual_hub.frc.id
  scale_unit          = 1
  tags                = {}
}

resource "azurerm_vpn_gateway" "swc" {
  name                = "b7472f1dd8064793b3d797943faee45e-swedencentral-gw"
  resource_group_name = azurerm_resource_group.hub_network.name
  location            = var.location_swc
  virtual_hub_id      = azurerm_virtual_hub.swc.id
  scale_unit          = 1
}

#--------------------------------------------------------------
# VPN Gateway Connections
#--------------------------------------------------------------
resource "azurerm_vpn_gateway_connection" "frc_to_dc" {
  name               = "Connection-vpns-hub-dc-frc"
  vpn_gateway_id     = azurerm_vpn_gateway.frc.id
  remote_vpn_site_id = azurerm_vpn_site.dc_frc.id

  vpn_link {
    name             = "PrimaryVpnGateway"
    vpn_site_link_id = azurerm_vpn_site.dc_frc.link[0].id
    bgp_enabled      = true
    bandwidth_mbps   = 10
    protocol         = "IKEv2"
  }

  vpn_link {
    name             = "SecondaryVpnGateway"
    vpn_site_link_id = azurerm_vpn_site.dc_frc.link[1].id
    bgp_enabled      = true
    bandwidth_mbps   = 10
    protocol         = "IKEv2"
  }

  routing {
    associated_route_table = azurerm_virtual_hub.frc.default_route_table_id

    propagated_route_table {
      route_table_ids = [azurerm_virtual_hub.frc.default_route_table_id]
      labels          = ["default"]
    }
  }
}

resource "azurerm_vpn_gateway_connection" "swc_to_dc" {
  name               = "Connection-vpns-hub-dc-frc"
  vpn_gateway_id     = azurerm_vpn_gateway.swc.id
  remote_vpn_site_id = azurerm_vpn_site.dc_frc.id

  vpn_link {
    name             = "PrimaryVpnGateway"
    vpn_site_link_id = azurerm_vpn_site.dc_frc.link[0].id
    bgp_enabled      = true
    bandwidth_mbps   = 10
    protocol         = "IKEv2"
  }

  vpn_link {
    name             = "SecondaryVpnGateway"
    vpn_site_link_id = azurerm_vpn_site.dc_frc.link[1].id
    bgp_enabled      = true
    bandwidth_mbps   = 10
    protocol         = "IKEv2"
  }

  routing {
    associated_route_table = azurerm_virtual_hub.swc.default_route_table_id

    propagated_route_table {
      route_table_ids = [azurerm_virtual_hub.swc.default_route_table_id]
      labels          = ["default"]
    }
  }
}
