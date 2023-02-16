#!/bin/bash

# Chamada create.sh <NAMESPACE>

set -e

NAMESPACE=$1

kubectl create namespace $NAMESPACE

kubectl create secret generic my-s3-keys --from-literal=access-key='minio' --from-literal=secret-key='minio123' -n $NAMESPACE


cd mariadb

sh create.sh $NAMESPACE

cd ..
cd hive_metastore

sh create.sh $NAMESPACE

cd ..

kubectl apply -n $NAMESPACE -f trino/trino-cfgs.yaml
kubectl apply -n $NAMESPACE -f trino/trino.yaml


