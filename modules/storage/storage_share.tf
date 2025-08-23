resource "azurerm_storage_share" "storage_share" {
  count = length(var.storage_shares)
  name = var.storage_shares[count.index]
  quota = 50
  storage_account_name = azurerm_storage_account.storage_account.name
}