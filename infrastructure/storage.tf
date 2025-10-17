resource "random_string" "stg_suffix" {
  length  = 5
  lower   = true
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "chatapp" {
  name                       = "chatappstg${random_string.stg_suffix.result}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

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
