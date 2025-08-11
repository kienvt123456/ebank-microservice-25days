#!/usr/bin/env bash
set -euo pipefail
USER=${1:?docker user required}
TAG=${2:-latest}
docker push $USER/eureka:$TAG
docker push $USER/api-gateway:$TAG
docker push $USER/payment-service:$TAG
docker push $USER/loan-service:$TAG
