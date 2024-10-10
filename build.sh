#!/bin/bash

docker build $build_args -t thiagopelizoni/fastfood-api:latest .

docker push thiagopelizoni/fastfood-api:latest