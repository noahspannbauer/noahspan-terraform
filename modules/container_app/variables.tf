variable "app_subdomain_name" {
  type = string
}

variable "containers" {
  type = list(object({
    name = string
    image = string
    cpu = string
    memory = string
  }))
  default = []
}

variable "container_app_name" {
  type = string
}

variable "container_app_environment_id" {
  type = string
}

variable "custom_domain_count" {
  type = string
}

variable "init_containers" {
  default = []
  type = list(object({
    name = string
    image = string
    cpu = string
    memory = string
  }))
}

variable "registry_password" {
  sensitive = true
  type = string
}

variable "registry_username" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "dns_zone_resource_group" {
  type = string
}

variable "ingress_external_enabled" {
  default = false
  type = bool
}

variable "ingress_allow_insecure_connections" {
  default = false
  type = bool
}

variable "ingress_target_port" {
  type = number
}

variable "ingress_transport" {
  default = "auto"
  type = string
}

variable "registry_password_secret_name" {
  default = "docker-io-password"
  type = string
}

variable "registry_server_name" {
  default = "index.docker.io"
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "secrets" {
  default = []
  type = list(object({
    name = string
    value = string
  }))
}

variable "storage_account_primary_connection_string" {
  type = string
}

variable "traffic_weight_percentage" {
  default = 100
  type = number
}

variable "template_min_replicas" {
  default = 0
  type = number
}

variable "template_max_replicas" {
  default = 1
  type = number
}