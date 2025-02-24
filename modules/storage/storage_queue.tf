resource "azurerm_storage_queue" "storage_queue" {
  count = length(var.storage_queues)
  name = var.storage_queues[count.index]
  storage_account_name = azurerm_storage_account.storage_account.name
}