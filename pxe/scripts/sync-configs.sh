#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="${SCRIPT_DIR}/../config"
CLUSTERCONFIG_DIR="${SCRIPT_DIR}/../../clusterconfig"

# MAC (hexhyp format) → config mapping
declare -A MAC_MAP=(
  ["58-47-ca-76-07-c4"]="home-cluster-cp-01.cluster.internal.yaml"
  ["58-47-ca-76-09-95"]="home-cluster-cp-02.cluster.internal.yaml"
  ["58-47-ca-76-08-d2"]="home-cluster-cp-03.cluster.internal.yaml"
  ["7c-83-34-be-c0-b4"]="home-cluster-wn-01.cluster.internal.yaml"
  ["68-1d-ef-36-c6-e3"]="home-cluster-wn-02.cluster.internal.yaml"
  ["58-47-ca-73-ce-2a"]="home-cluster-wn-03.cluster.internal.yaml"
)

mkdir -p "$CONFIG_DIR"

for mac in "${!MAC_MAP[@]}"; do
  src="${CLUSTERCONFIG_DIR}/${MAC_MAP[$mac]}"
  dst="${CONFIG_DIR}/${mac}.yaml"
  if [[ -f "$src" ]]; then
    cp "$src" "$dst"
    echo "Synced: ${MAC_MAP[$mac]} → ${mac}.yaml"
  else
    echo "WARNING: $src not found" >&2
  fi
done
