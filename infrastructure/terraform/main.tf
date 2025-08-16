terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
   
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
  subscription_id = "b5f42d6d-c117-422b-9a2c-dcf0001bb4be"
  tenant_id       = "8ddcf98f-3188-4551-984e-159172c5386d"

}

provider "azuread" {}
provider "random" {}

module "terraform_backend" {
  source               = "./modules/tf_backend"
  resource_group_name  = "tf-state-rg"
  location             = "East US 2"
  storage_account_name = "tfstateaksotel"
  container_name       = "tfstate"
}

output "sp_client_id" {
  value = module.terraform_backend.sp_client_id
}

output "sp_client_secret" {
  value     = module.terraform_backend.sp_client_secret
  sensitive = true
}

output "sp_tenant_id" {
  value = "8ddcf98f-3188-4551-984e-159172c5386d" #module.terraform_backend.sp_tenant_id
}

output "storage_account_name" {
  value = module.terraform_backend.storage_account_name
}

output "container_name" {
  value = module.terraform_backend.container_name
}

data "sops_file" "secrets" {
  source_file = "${path.module}/secrets.auto.tfvars.enc.yaml"
}

