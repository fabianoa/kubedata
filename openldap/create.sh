#!/bin/bash

# Chamada create.sh <NAMESPACE>

set -e

NAMESPACE=$1

kubectl apply -n $NAMESPACE -f openldap.yaml

# wait for mysql pod being ready.
while [[ $(kubectl get pods -n $NAMESPACE -l app=openldap-srv -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for openldap-srv pod being ready" && sleep 1; done
