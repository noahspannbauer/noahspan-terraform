variable "container_app_environment_name" {
  type = string
}

variable "log_analytics_workspace_name" {
  type = string
}

variable "log_analytics_workspace_retention_in_days" {
  default = 30
}

variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
  type = string
}

variable "resource_group_name" {
  type = string
}