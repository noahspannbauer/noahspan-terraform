resource "azurerm_container_app" "container_app_app" {
  name = var.container_app_name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name = data.azurerm_resource_group.resource_group.name
  revision_mode = "Single"

  registry {
    server = var.registry_server_name
    username = var.registry_username
    password_secret_name = var.registry_password_secret_name
  }

  template {
    min_replicas = var.template_min_replicas
    max_replicas = var.template_max_replicas

    dynamic "init_container" {
      for_each = var.init_containers
      content {
        name = init_container.value["name"]
        image = container.value["image"]
        cpu = init_container.value["cpu"]
        memory = init_container.value["memory"]
      }
    }

    dynamic "container" {
      for_each = var.containers
      content {
        name = container.value["name"]
        image = container.value["image"]
        cpu = container.value["cpu"]
        memory = container.value["memory"]
      }
    }
  }

  ingress {
    allow_insecure_connections = var.ingress_allow_insecure_connections
    external_enabled = var.ingress_external_enabled
    target_port = var.ingress_target_port
    transport = var.ingress_transport

    traffic_weight {
      latest_revision = true
      percentage = var.traffic_weight_percentage
    }
  }

  dynamic "secret" {
    for_each = var.secrets
    content {
      name = secret.value["name"]
      value = secret.value["value"]
    }
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