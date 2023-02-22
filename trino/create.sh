#!/bin/bash

# Chamada create.sh <NAMESPACE>

set -e

NAMESPACE=$1

kubectl apply -n $NAMESPACE -f trino-cfg.yaml
kubectl apply -n $NAMESPACE -f trino.yaml

# wait for mysql pod being ready.
while [[ $(kubectl get pods -n $NAMESPACE -l app=trino -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for trino pod being ready" && sleep 1; done
