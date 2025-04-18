resource "azurerm_storage_account_static_website" "static_website" {
  count = length(var.storage_tables)
  storage_account_id = azurerm_storage_account.storage_account.id
  error_404_document = var.static_websites[count.index].error_404_document
  index_document     = var.static_websites[count.index].index_document
}