locals {
  env                 = "dev"
  region              = "eastus2"
  resource_group_name = "aks-otel-rg"
  aks_name            = "prod-eus2-aks"
  aks_version         = "1.28.6"
  subscription_id     = data.sops_file.secrets.data["subscription_id"]
  tenant_id           = data.sops_file.secrets.data["tenant_id"]
  client_id           = data.sops_file.secrets.data["client_id"]
  client_secret       = data.sops_file.secrets.data["client_secret"]
}
