variable "app_subdomain_name" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  sensitive = true
  type = string
}

variable "container_app_app_name" {
  type = string
}

variable "container_app_app_container_image" {
  type = string
}

variable "container_app_app_container_name" {
  type = string
}

variable "container_app_api_name" {
  type = string
}

variable "container_app_api_container_image" {
  type = string
}

variable "container_app_api_container_name" {
  type = string
}

variable "container_app_environment_name" {
  type = string
}

variable "custom_domain_count" {
  type = string
}

variable "docker_io_password" {
  sensitive = true
  type = string
}

variable "docker_io_username" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "dns_zone_resource_group" {
  type = string
}

variable "log_analytics_workspace_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_tables" {
  type = list(string)
}

variable "tenant_id" {
  type = string
}