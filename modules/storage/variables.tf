variable "account_replication_type" {
  default = "LRS"
  type = string
}

variable "account_tier" {
  default = "Standard"
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "static_websites" {
  default = []
  type = list(object({
    error_404_document = string
    index_document = string
  }))
}

variable "storage_account_name" {
  type = string
}

variable "storage_blobs" {
  default = []
  type = list(object({
    name = string,
    storage_container_name = string,
    type = string,
    content_type = string,
    source = string
  }))
}

variable "storage_containers" {
  default = []
  type = list(string)
}

variable "storage_queues" {
  default = []
  type = list(string)
}

variable "storage_tables" {
  default = []
  type = list(string)
}