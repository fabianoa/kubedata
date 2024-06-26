#!/bin/bash

# Chamada create.sh <NAMESPACE>

set -e

helm repo add apache-airflow https://airflow.apache.org
helm upgrade --install airflow apache-airflow/airflow --namespace airflow --create-namespace -f override-values.yaml
