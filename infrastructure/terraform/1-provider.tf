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
     sops = {
      source  = "carlpett/sops"
      version = "1.2.1"
    }
     azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "azurerm" {
  features {}
  use_cli         = true
  subscription_id = data.sops_file.secrets.subscription_id
  tenant_id       = data.sops_file.secrets.tenant_id
  client_id       = data.sops_file.secrets.client_id
  client_secret   = data.sops_file.secrets.client_secret

} 