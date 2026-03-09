variable "subscription_id" {
  description = "Azure subscription ID for the Hub subscription"
  type        = string
  default     = "8c315d4c-9df6-4317-b076-ddfb4e38dd82"
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  default     = "06ad612a-3aea-4e76-a4bf-0f60c6c430bc"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-hub-network"
}

variable "location_frc" {
  description = "Primary location (France Central)"
  type        = string
  default     = "francecentral"
}

variable "location_swc" {
  description = "Secondary location (Sweden Central)"
  type        = string
  default     = "swedencentral"
}

variable "vwan_address_prefix_frc" {
  description = "Address prefix for the France Central Virtual Hub"
  type        = string
  default     = "10.254.1.0/24"
}

variable "vwan_address_prefix_swc" {
  description = "Address prefix for the Sweden Central Virtual Hub"
  type        = string
  default     = "10.254.32.0/24"
}

variable "vpn_site_primary_ip" {
  description = "IP address of the primary VPN gateway on-premises"
  type        = string
  default     = "172.189.159.242"
}

variable "vpn_site_secondary_ip" {
  description = "IP address of the secondary VPN gateway on-premises"
  type        = string
  default     = "4.178.10.170"
}

variable "vpn_site_bgp_asn" {
  description = "BGP ASN of the on-premises VPN site"
  type        = number
  default     = 65042
}

variable "vpn_site_primary_bgp_address" {
  description = "BGP peering address of the primary on-premises VPN gateway"
  type        = string
  default     = "100.64.0.4"
}

variable "vpn_site_secondary_bgp_address" {
  description = "BGP peering address of the secondary on-premises VPN gateway"
  type        = string
  default     = "100.64.0.5"
}

variable "vpn_link_speed_mbps" {
  description = "Speed of the VPN links in Mbps"
  type        = number
  default     = 500
}

variable "vpn_link_provider" {
  description = "VPN link provider name"
  type        = string
  default     = "MSWAN"
}

variable "firewall_private_ip" {
  description = "Private IP of the Azure Firewall used as next hop"
  type        = string
  default     = "10.0.0.4"
}
