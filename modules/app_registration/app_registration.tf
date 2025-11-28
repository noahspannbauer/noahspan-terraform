data "azuread_client_config" "current" {}

data "azuread_application_published_app_ids" "well_known" {}

resource "random_uuid" "oauth2_permission_scope_uuid" {}

resource "random_uuid" "read_app_role_uuid" {}

resource "random_uuid" "write_app_role_uuid" {}

resource "azuread_application" "app_registration" {
  display_name = var.app_reg_name
  owners = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  api {
    requested_access_token_version = 2

    dynamic "oauth2_permission_scope" {
      for_each = var.oauth2_permission_scopes != null ? var.oauth2_permission_scopes : []
      iterator = oauth2_permission_scope
      content {
        admin_consent_description = oauth2_permission_scope.value.admin_consent_description
        admin_consent_display_name = oauth2_permission_scope.value.admin_consent_display_name
        enabled = oauth2_permission_scope.value.enabled
        id = oauth2_permission_scope.value.id
        type = oauth2_permission_scope.value.type
        user_consent_description = oauth2_permission_scope.value.user_consent_description
        user_consent_display_name = oauth2_perimission_scope.value.user_consent_display_name
        value = oauth2_perimission_scope.value.value
      }
    }
  }

  dynamic "app_role" {
    for_each = var.app_roles != null ? var.app_roles : []
    iterator = app_role
    content {
      allowed_member_types = app_role.value.allowed_member_types
      description = app_role.value.description
      display_name = app_role.value.display_name
      enabled = app_role.value.enabled
      id = app_role.value.id
      value = app_role.value.value
    }
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]

    resource_access {
      id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # email
      type = "Scope"
    }

    resource_access {
      id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # openid
      type = "Scope"
    }

    resource_access {
      id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # profile
      type = "Scope"
    }

    resource_access {
      id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Role"
    }

    dynamic "resource_access" {
      for_each = var.additional_resource_access != null ? var.additional_resource_access : []
      iterator = resource_access
      content {
        id = resource_access.value.id
        type = resource_access.value.type
      }
    }
  }

  single_page_application {
    redirect_uris = var.redirect_uris != null ? var.redirect_uris : []
  }

  web {
    implicit_grant {
      access_token_issuance_enabled = var.access_token_issuance_enabled != null ? var.access_token_issuance_enabled : false
      id_token_issuance_enabled     = var.id_token_issuance_enabled != null ? var.id_token_issuance_enabled : false
    }
  }

  lifecycle {
    ignore_changes = [ 
      identifier_uris, password
     ]
  }
}

resource "azuread_application_identifier_uri" "app_registration_identifier_uri" {
  count = var.enable_identifier_uri != null ? 1 : 0
  application_id = azuread_application.app_registration.id
  identifier_uri = "api://${azuread_application.app_registration.client_id}"
}

resource "azuread_application_federated_identity_credential" "github_actions_federated_identity_credential" {
  count = var.federated_identity_credential != null ? 1 : 0
  application_id = azuread_application.app_registration.id
  display_name   = "github-actions"
  description    = "Deployments for flying repo"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = module.environment.app_reg_federated_identity_credential_subject
}

resource "azuread_application_password" "app_registration_secret" {
  count = var.secret != null ? 1 : 0
  application_id = azuread_application.app_registration.id
  display_name = var.secret.display_name
  end_date = var.secret.end_date != null ? var.secret.end_date : null
}

