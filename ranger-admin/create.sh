
#!/bin/bash

# Chamada create.sh <NAMESPACE>

set -e

NAMESPACE=$1

kubectl apply -n $NAMESPACE -f ranger-cfg.yaml
kubectl apply -n $NAMESPACE -f ranger-addmin.yaml

# wait for mysql pod being ready.
while [[ $(kubectl get pods -n $NAMESPACE -l app=ranger-admin -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for ranger-admin pod being ready" && sleep 1; done
