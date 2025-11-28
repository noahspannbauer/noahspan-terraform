output "app_registration_secret" {
  value = one(azuread_application_password.app_registration_secret[*].value)
}