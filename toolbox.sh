#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink --canonicalize "$0"))
pushd "${SCRIPT_DIR}"
docker-compose up -d
container_name=$(docker ps -q --filter "label=name=m-toolbox")
docker exec -it $container_name /bin/bash
