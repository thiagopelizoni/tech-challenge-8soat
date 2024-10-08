#!/bin/bash

export $(grep -v '^#' .env | xargs)

build_args=$(grep -v '^#' .env | sed 's/^/--build-arg /' | xargs)

docker build $build_args -t thiagopelizoni/fastfood-api:latest .