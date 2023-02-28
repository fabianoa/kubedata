#!/bin/bash

# Chamada create.sh <NAMESPACE>

set -e

NAMESPACE=$1

#kubectl apply -n $NAMESPACE -f maria_pvc.yaml
kubectl apply -n $NAMESPACE -f nifi.yaml

# wait for mysql pod being ready.
while [[ $(kubectl get pods -n $NAMESPACE -l app=nifi -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for nifi pod being ready" && sleep 1; done
