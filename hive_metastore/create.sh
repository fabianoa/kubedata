
#!/bin/bash

# Chamada create.sh <NAMESPACE>

set -e

NAMESPACE=$1

# create metastore db schemas.
kubectl apply -n $NAMESPACE -f hive-initschema.yaml

# wait for finishing creating schemas.
while [[ $(kubectl get pods -n $NAMESPACE -l job-name=hive-initschema -o jsonpath={..status.phase}) != *"Succeeded"* ]]; do echo "waiting for finishing init schema job" && sleep 2; done

kubectl apply -n $NAMESPACE -f metastore-cfg.yaml
kubectl apply -n $NAMESPACE -f metastore.yaml

# wait for mysql pod being ready.
while [[ $(kubectl get pods -n $NAMESPACE -l app=metastore -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for metastore pod being ready" && sleep 1; done
