#--------------------------------------------------------------
# Storage Accounts (Flow Logs)
#--------------------------------------------------------------
resource "azurerm_storage_account" "flowlogs_frc" {
  name                            = "sahubflowlogsfrc"
  resource_group_name             = azurerm_resource_group.hub_network.name
  location                        = var.location_frc
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  access_tier                     = "Hot"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  cross_tenant_replication_enabled = false
  tags                            = {}

  network_rules {
    default_action = "Allow"
    bypass         = ["AzureServices"]

    private_link_access {
      endpoint_resource_id = "/subscriptions/${var.subscription_id}/providers/Microsoft.Security/datascanners/StorageDataScanner"
      endpoint_tenant_id   = var.tenant_id
    }
  }
}

resource "azurerm_storage_account" "flowlogs_swc" {
  name                            = "sahubflowlogsswc"
  resource_group_name             = azurerm_resource_group.hub_network.name
  location                        = var.location_swc
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  access_tier                     = "Hot"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  cross_tenant_replication_enabled = false
  tags                            = {}

  network_rules {
    default_action = "Allow"
    bypass         = ["AzureServices"]

    private_link_access {
      endpoint_resource_id = "/subscriptions/${var.subscription_id}/providers/Microsoft.Security/datascanners/StorageDataScanner"
      endpoint_tenant_id   = var.tenant_id
    }
  }
}

#--------------------------------------------------------------
# EventGrid System Topics (auto-created for storage accounts)
#--------------------------------------------------------------
resource "azurerm_eventgrid_system_topic" "flowlogs_frc" {
  name                = "sahubflowlogsfrc-95aae5f5-3afd-4795-b741-94c97efc8dfd"
  resource_group_name = azurerm_resource_group.hub_network.name
  location            = var.location_frc
  source_resource_id  = azurerm_storage_account.flowlogs_frc.id
  topic_type          = "microsoft.storage.storageaccounts"
}

resource "azurerm_eventgrid_system_topic" "flowlogs_swc" {
  name                = "sahubflowlogsswc-bba2dac5-58d5-4c70-a0cf-2f59ee36b2ed"
  resource_group_name = azurerm_resource_group.hub_network.name
  location            = var.location_swc
  source_resource_id  = azurerm_storage_account.flowlogs_swc.id
  topic_type          = "microsoft.storage.storageaccounts"
}
