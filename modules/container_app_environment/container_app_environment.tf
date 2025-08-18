resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name = var.log_analytics_workspace_name
  location = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  sku = var.log_analytics_workspace_sku
  retention_in_days = var.log_analytics_workspace_retention_in_days
}

resource "azurerm_container_app_environment" "container_app_environment" {
  name = var.container_app_environment_name
  location = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}