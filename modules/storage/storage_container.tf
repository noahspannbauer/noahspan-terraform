resource "azurerm_storage_container" "storage_container" {
  count = length(var.storage_containers)
  name                  = var.storage_containers[count.index]
  storage_account_id    = azurerm_storage_account.storage_account.id
  container_access_type = "private"
}