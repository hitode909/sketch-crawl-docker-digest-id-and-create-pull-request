#!/bin/bash
set -ex
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USERNAME}'", "password": "'${DOCKER_PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/amazon/aws-cli/tags | jq -r '.results[] | select(.name=="latest").images[] | [select(.architecture=="amd64")][0].digest' > digest.txt