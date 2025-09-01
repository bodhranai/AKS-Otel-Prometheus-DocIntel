#!/usr/bin/env bash
set -euo pipefail
export MSYS_NO_PATHCONV=1

# Variables
REGION="westus"
TFVARS_FILE=".\env\prod\terraform.tfvars"
CANDIDATE_SIZES=("Standard_DS2_v2" "Standard_DS2" "Standard_B2ms" "Standard_D2s_v3")

echo "🔍 Checking available VM sizes in $REGION..."

# Get list of available SKUs in the region
AVAILABLE_SIZES=$(az vm list-skus --location "$REGION" --size "*" --query "[?capabilities[?name=='vCPUs']].name" -o tsv)

# Pick first matching candidate
SELECTED_SIZE=""
for SIZE in "${CANDIDATE_SIZES[@]}"; do
    if echo "$AVAILABLE_SIZES" | grep -qw "$SIZE"; then
        SELECTED_SIZE="$SIZE"
        break
    fi
done

if [[ -z "$SELECTED_SIZE" ]]; then
    echo "❌ No candidate VM sizes are available in $REGION."
    exit 1
fi

echo "✅ Selected VM size: $SELECTED_SIZE"

# Update or insert into terraform.tfvars
if grep -q "^user_node_vm_size" "$TFVARS_FILE"; then
    sed -i.bak "s/^user_node_vm_size.*/user_node_vm_size = \"$SELECTED_SIZE\"/" "$TFVARS_FILE"
else
    echo "user_node_vm_size = \"$SELECTED_SIZE\"" >> "$TFVARS_FILE"
fi

echo "📄 Updated $TFVARS_FILE with: user_node_vm_size = \"$SELECTED_SIZE\""
