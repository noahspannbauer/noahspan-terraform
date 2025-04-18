resource "azurerm_storage_account" "storage_account" {
    name = var.storage_account_name
    resource_group_name = data.azurerm_resource_group.resource_group.name
    location = data.azurerm_resource_group.resource_group.location
    account_tier = var.account_tier
    account_replication_type = var.account_replication_type

    dynamic static_website {
        for_each = var.static_websites

        content {
            index_document = static_website.value.index_document
        }
    }
}