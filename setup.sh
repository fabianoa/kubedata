#!/bin/bash

set -e

NAMESPACE=kube-datalake

kubectl create namespace $NAMESPACE
kubectl create secret generic my-s3-keys --from-literal=access-key='minio' --from-literal=secret-key='minio123' -n $NAMESPACE



kubectl apply -n $NAMESPACE -f mariadb/maria_pvc.yaml
kubectl apply -n $NAMESPACE -f mariadb/maria_deployment.yaml

kubectl apply -n $NAMESPACE -f hive_metastore/hive-initschema.yaml

kubectl create configmap metastore-cfg -n $NAMESPACE  --from-file=hive_metastore/metastore-site.xml  -o yaml | kubectl apply -n $NAMESPACE -f -

kubectl apply -n $NAMESPACE -f hive_metastore/metastore.yaml


kubectl apply -n $NAMESPACE -f trino/trino-cfgs.yaml
kubectl apply -n $NAMESPACE -f trino/trino.yaml
