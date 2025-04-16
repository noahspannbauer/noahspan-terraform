resource "azurerm_storage_blob" "storage_blob" {
  count = length(var.storage_blobs)
  name = var.storage_blobs[count.index].name
  storage_account_name = azurerm_storage_account.storage_account.name
  storage_container_name = var.storage_blobs[count.index].name
  type = var.storage_blobs[count.index].type
  content_type = var.storage_blobs[count.index].content_type
  source = var.storage_blobs[count.index].source
}