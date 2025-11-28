output "app_registration_secret" {
  value = var.secret != null ? azuread_application_password.app_registration_secret.value : null
}