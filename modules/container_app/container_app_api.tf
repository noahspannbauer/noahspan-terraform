resource "azurerm_container_app" "container_app_api" {
  name = var.container_app_api_name
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name = data.azurerm_resource_group.resource_group.name
  revision_mode = "Single"

  registry {
    server = "index.docker.io"
    username = var.docker_io_username
    password_secret_name = "docker-io-password"
  }

  template {
    min_replicas = 0
    max_replicas = 2

    container {
      name = var.container_app_api_container_name
      image = var.container_app_api_container_image
      cpu = 0.25
      memory = "0.5Gi"

      env {
        name = "AZURE_STORAGE_CONNECTION_STRING"
        secret_name = "azure-storage-connection-string"
      }

      env {
        name = "CLIENT_ID"
        secret_name = "client-id"
      }

      env {
        name = "CLIENT_SECRET"
        secret_name = "client-secret"
      }

      env {
        name = "TENANT_ID"
        secret_name = "tenant-id"
      }
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled = true
    target_port = 3000
    transport = "auto"

    traffic_weight {
      latest_revision = true
      percentage = 100
    }
  }

  secret {
    name = "docker-io-password"
    value = var.docker_io_password
  }

  secret {
    name = "azure-storage-connection-string"
    value = var.storage_account_primary_connection_string
  }

  secret {
    name = "client-id"
    value = var.client_id
  }

  secret {
    name = "client-secret"
    value = var.client_secret
  }

  secret {
    name = "tenant-id"
    value = var.tenant_id
  }

  lifecycle {
    ignore_changes = [ template[0].container[0].image ]
  }
}