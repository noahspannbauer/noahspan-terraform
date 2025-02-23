resource "azurerm_storage_account" "storage_account" {
    name = var.storage_account_name
    resource_group_name = data.azurerm_resource_group.resource_group.name
    location = data.azurerm_resource_group.resource_group.location
    account_tier = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_storage_table" "storage_table" {
  count = length(var.storage_tables)
  name = var.storage_tables[count.index]
  storage_account_name = azurerm_storage_account.storage_account.name
}