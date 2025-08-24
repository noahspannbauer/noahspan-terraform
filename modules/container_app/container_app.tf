resource "azurerm_container_app" "container_app_app" {
  name = var.container_app_name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name = data.azurerm_resource_group.resource_group.name
  revision_mode = "Single"

  template {
    min_replicas = var.template_min_replicas
    max_replicas = var.template_max_replicas

    dynamic "init_container" {
      for_each = length(var.init_containers) > 0 ? var.init_containers : []
      iterator = init_container
      content {
        args = init_container.value.args != null ? init_container.value.args : []
        command = init_container.value.command != null ? init_container.value.command : []
        cpu = init_container.value.cpu
        image = "${init_container.value.image}"
        memory = init_container.value.memory
        name = init_container.value.name

        dynamic "env" {
          for_each = init_container.value.envs != null ? init_container.value.envs : []
          iterator = env
          content {
            name = env.value.name
            secret_name = env.value.secret_name
            value = env.value.value
          }
        }

        dynamic "volume_mounts" {
          for_each = init_container.value.volume_mounts != null ? init_container.value.volume_mounts : []
          iterator = volume_mount
          content {
            name = volume_mount.value.name
            path = volume_mount.value.path
            sub_path = volume_mount.value.sub_path != null ? volume_mount.value.sub_path : null
          }
        }
      }
    }

    dynamic "container" {
      for_each = var.containers
      iterator = container
      content {
        args = container.value.args != null ? container.value.args : []
        command = container.value.command != null ? container.value.command : []
        cpu = container.value.cpu
        image = "${container.value.image}"
        memory = container.value.memory
        name = container.value.name

        dynamic "env" {
          for_each = container.value.envs != null ? container.value.envs : []
          iterator = env
          content {
            name = env.value.name
            secret_name = env.value.secret_name
            value = env.value.value
          }
        }

        dynamic "volume_mounts" {
          for_each = container.value.volume_mounts != null ? container.value.volume_mounts : []
          iterator = volume_mount
          content {
            name = volume_mount.value.name
            path = volume_mount.value.path
            sub_path = volume_mount.value.sub_path != null ? volume_mount.value.sub_path : null
          }
        }
      }
    }

    dynamic "volume" {
      for_each = var.volume
      iterator = volume
      content {
        name = volume.value.name
        storage_name = volume.value.storage_name
        storage_type = volume.value.storage_type
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

  registry {
    server = "${var.registry_server_name}"
    username = var.registry_username
    password_secret_name = var.registry_password_secret_name
  }

  dynamic "secret" {
    for_each = length(var.secrets) > 0 ? var.secrets : []
    iterator = secret
    content {
      name = secret.value.name
      value = secret.value.value
    }
  }

  lifecycle {
    ignore_changes = [ template[0].container[0].image, template[0].container[0].image, template[0].init_container[0].image, registry[0].server ]
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