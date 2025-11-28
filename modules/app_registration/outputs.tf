output "app_registration_secret" {
  value = azuread_application_password.app_registration_secret.value
}