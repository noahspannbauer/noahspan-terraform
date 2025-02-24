resource "azurerm_storage_table" "storage_table" {
  count = length(var.storage_tables)
  name = var.storage_tables[count.index]
  storage_account_name = azurerm_storage_account.storage_account.name
}