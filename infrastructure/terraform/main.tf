terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }

  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "AKS-Otel-Prometheus-DocIntel-rg"
  location = "East US"
}
