variable "access_token_issuance_enabled" {
  default = null
  type = bool
}

variable "id_token_issuance_enabled" {
  default = null
  type = bool
}

variable "additional_resource_access" {
  default = null
  type = list(object({
    id = string
    type = string
  }))
}

variable "app_roles" {
  default = null
  type = list(object({
    allowed_member_types = list(string)
    description = string
    display_name = string
    enabled = bool
    id = string
    value = string
  }))
}

variable "app_reg_name" {
  type = string
}

variable "azuread_provider_alias" {
  type = string
}

variable "client_id" {
  default = null
  type = string
}

variable "client_secret" {
  default = null
  sensitive = true
  type = string
}

variable "destination" {
  type = string
}

variable "federated_identity_credential" {
  default = null
  type = object({
    display_name = string
    description = string
    audiences = list(string)
    issuer = string
    subject = string
  })
}

variable "enable_identifier_uri" {
  default = null
  type = bool
}

variable "oauth2_permission_scopes" {
  default = null
  type = list(object({
    admin_consent_description = string
    admin_consent_display_name = string
    enabled = bool
    id = string
    type = string
    user_consent_description = string
    user_consent_display_name = string
    value = string
  }))
}

variable "secret" {
  default = null
  type = object({
    display_name = string
    end_date = optional(string)
  })
}

variable "redirect_uris" {
  default = null
  type = list(string)
}

variable "tenant_id" {
  type = string
}