terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.41.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.38.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=3.0.2"
    }
    sops = {
      source  = "carlpett/sops"
      version = ">=1.2.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.7.2"
    }
  }
}

provider "kubernetes" {
  host                   = module.aks.kube_config.host
  client_certificate     = base64decode(module.aks.kube_config.client_certificate)
  client_key             = base64decode(module.aks.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
}


// @ts-ignore
provider "helm" {
  kubernetes = {
    host                   = module.aks.kube_config.host
    client_certificate     = base64decode(module.aks.kube_config.client_certificate)
    client_key             = base64decode(module.aks.kube_config.client_key)
    cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
  }
}

data "sops_file" "secrets" {
  source_file = "secrets.auto.tfvars.enc.yaml"
}


provider "azurerm" {
  features {}
  subscription_id = data.sops_file.secrets.data["subscription_id"]
  tenant_id       = data.sops_file.secrets.data["tenant_id"]
  client_id       = data.sops_file.secrets.data["client_id"]
  client_secret   = data.sops_file.secrets.data["client_secret"]

}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "tfstateaksotel"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

