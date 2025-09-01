#!/bin/bash
set -euo pipefail
export MSYS_NO_PATHCONV=1


# -----------------------------
# Load environment variables
# -----------------------------
source variables.env



# -----------------------------
# Dynamically get subnet ID
# -----------------------------
# Git Bash on Windows can mangle paths, so always quote properly
VNET_SUBNET_ID=$(az network vnet subnet show \
  --resource-group "$VNET_RESOURCE_GROUP" \
  --vnet-name "$VNET_NAME" \
  --name "$SUBNET_NAME" \
  --query "id" -o tsv)

# Strip any accidental whitespace or quotes
VNET_SUBNET_ID=$(echo "$VNET_SUBNET_ID" | tr -d '\r\n[:space:]' | sed 's/^"//;s/"$//')

echo "Using subnet id: $VNET_SUBNET_ID"

# -----------------------------
# Validate subnet ID
# -----------------------------
if ! az network vnet subnet show --ids "$VNET_SUBNET_ID" >/dev/null; then
  echo "❌ Subnet ID is invalid or not found."
  exit 1
fi

# -----------------------------
# Set subscription (ensure correct one)
# -----------------------------
az account set --subscription "$SUBSCRIPTION_ID"

# -----------------------------
# Create AKS cluster
# -----------------------------
echo "Creating AKS cluster: ${ENV}-${CLUSTER_NAME} in ${LOCATION}..."
az aks create \
  --name "${ENV}-${CLUSTER_NAME}" \
  --resource-group "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --vnet-subnet-id "$VNET_SUBNET_ID" \
  --node-count 3 \
  --enable-managed-identity \
  --generate-ssh-keys \
  --network-plugin azure \
  --network-policy azure \
  --network-plugin-mode overlay \
  --dns-service-ip "$DNS_SERVICE_IP" \
  --service-cidr "$SERVICE_CIDR" \
  --pod-cidr "$POD_CIDR" \
 
  --nodepool-name "$NODEPOOL_NAME" \
  --node-vm-size "$NODE_VM_SIZE" \
  --no-wait \
  --debug

echo "✅ AKS cluster creation started. Monitor progress with:"
echo "   az aks show --name ${ENV}-${CLUSTER_NAME} --resource-group ${RESOURCE_GROUP}"
