# Generate a short suffix so names are globally unique
resource "random_string" "stg_suffix" {
  length  = 5
  lower   = true
  upper   = false
  numeric = true
  special = false
}

locals {
  stg_name = "chatappstg${random_string.stg_suffix.result}"
}

# Use the same RG and location as your main stack
# (assumes you already have azurerm_resource_group.main defined in main.tf)
resource "azurerm_storage_account" "chatapp" {
  name                = local.stg_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  blob_properties {
    delete_retention_policy { days = 7 }
    container_delete_retention_policy { days = 7 }
    versioning_enabled = true
  }

  identity { type = "SystemAssigned" }

  tags = {
    app = "chatapp"
    env = "interview"
  }
}

resource "azurerm_storage_container" "chatapp_data" {
  name                  = "appdata"
  storage_account_name  = azurerm_storage_account.chatapp.name
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.chatapp.name
}

output "blob_container_name" {
  value = azurerm_storage_container.chatapp_data.name
}
