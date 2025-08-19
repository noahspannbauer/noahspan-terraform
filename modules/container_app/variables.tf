variable "app_subdomain_name" {
  default = ""
  type = string
}

variable "containers" {
  default = []
  type = list(object({
    command = optional(string)
    cpu = optional(string)
    envs = optional(list(object({
      name = string
      secret_name = optional(string)
      value = optional(string)
    })))
    image = string
    memory = optional(string)
    name = string
    volume_mounts = optional(list(object({
      name = string
      path = string
    })))
  }))
}

variable "container_app_name" {
  type = string
}

variable "container_app_environment_id" {
  type = string
}

variable "custom_domain_count" {
  default = 0
  type = string
}

variable "dns_zone_resource_group" {
  default = ""
  type = string
}

variable "domain_name" {
  default = ""
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
  default = 3000
  type = number
}

variable "ingress_transport" {
  default = "auto"
  type = string
}

variable "init_containers" {
  default = []
  type = list(object({
    command = optional(string)
    cpu = optional(string)
    envs = optional(list(object({
      name = string
      secret_name = optional(string)
      value = optional(string)
    })))
    image = string
    memory = optional(string)
    name = string
    volume_mounts = optional(list(object({
      name = string
      path = string
    })))
  }))
}

variable "registry_password" {
  sensitive = true
  type = string
}

variable "registry_username" {
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
  default = ""
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