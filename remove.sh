#!/bin/bash

kubectl delete -f kubernetes/api-service.yml
kubectl delete -f kubernetes/api-deployment.yml
kubectl delete -f kubernetes/db-service.yml
kubectl delete -f kubernetes/db-deployment.yml
kubectl delete -f kubernetes/postgres-pvc.yml
kubectl delete -f kubernetes/api-pvc.yml
kubectl delete -f kubernetes/secret.yml