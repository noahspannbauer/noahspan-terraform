terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      configuration_aliases = [ azuread.entra ]
    }
  }
}