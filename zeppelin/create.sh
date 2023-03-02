
#!/bin/bash

# Chamada create.sh <NAMESPACE>

set -e

NAMESPACE=$1

kubectl apply -n $NAMESPACE -f zeppelin-cfg.yaml
kubectl apply -n $NAMESPACE -f zeppelin-server.yaml

# wait for mysql pod being ready.
while [[ $(kubectl get pods -n $NAMESPACE -l app=zeppelin-server -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for zeppelin-server pod being ready" && sleep 1; done
