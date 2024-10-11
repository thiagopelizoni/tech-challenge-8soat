#!/bin/bash

kubectl apply -f kubernetes/secret.yml
kubectl apply -f kubernetes/api-pvc.yml
kubectl apply -f kubernetes/db-pvc.yml
kubectl apply -f kubernetes/db-deployment.yml
kubectl apply -f kubernetes/db-service.yml
kubectl apply -f kubernetes/api-deployment.yml
kubectl apply -f kubernetes/api-service.yml