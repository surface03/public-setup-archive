#!/bin/bash

if [ $# -lt 2 ]; then
  echo "사용법: bash $0 <이름_패턴> <네임스페이스>"
  exit 1
fi

TARGET_NAME=$1
NAMESPACE=$2

RESOURCE_TYPES=("pod" "deployment" "service" "replicaset" "ingress" "configmap" "secret" "pvc" "hpa")


for r in "${RESOURCE_TYPES[@]}"
do
  output=$(kubectl get "$r" -n "$NAMESPACE" --ignore-not-found | grep "$TARGET_NAME")
  if [[ -n "$output" ]]; then
    echo "=== $r (namespace: $NAMESPACE) ==="
    echo "$output"
    echo
  fi
done
