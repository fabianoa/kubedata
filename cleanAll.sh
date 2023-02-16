#!/bin/bash

# Chamada create.sh <NAMESPACE>

set -e

NAMESPACE=$1

kubectl delete namespace $NAMESPACE &
sleep 1m
kubectl get namespace $NAMESPACE -o json | jq 'del(.spec.finalizers[0])' | kubectl replace --raw "/api/v1/namespaces/$NAMESPACE/finalize" -f -
