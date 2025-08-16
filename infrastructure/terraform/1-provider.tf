 terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.39.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
  }
}

provider "azurerm" {
  features {}
  use_cli         = true
  subscription_id = "b5f42d6d-c117-422b-9a2c-dcf0001bb4be"
  tenant_id       = "8ddcf98f-3188-4551-984e-159172c5386d"
  client_id         = "<service_principal_appid>"
  client_secret     = "<service_principal_password>"
                     
} 