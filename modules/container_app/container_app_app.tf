resource "azurerm_container_app" "container_app_app" {
  name = var.container_app_app_name
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
      name = var.container_app_app_container_name
      image = var.container_app_app_container_image
      cpu = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled = true
    target_port = 8080
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

  lifecycle {
    ignore_changes = [ template[0].container[0].image ]
  }
}

resource "azurerm_container_app_custom_domain" "custom_domain" {
  count = var.custom_domain_count
  name = trimsuffix(trimprefix(azurerm_dns_txt_record.dns_txt_record[0].fqdn, "asuid."), ".")
  container_app_id = azurerm_container_app.container_app_app.id
  
  lifecycle {
    ignore_changes = [ certificate_binding_type, container_app_environment_certificate_id ]
  }
}