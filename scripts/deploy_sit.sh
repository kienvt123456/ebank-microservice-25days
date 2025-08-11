#!/usr/bin/env bash
set -euo pipefail
NS=sit
USER=${1:-your-docker-user}
TAG=${2:-latest}

kubectl create ns sit || true

helm upgrade --install eureka helm/charts/eureka -n sit -f helm/env/values-sit.yaml   --set image.repository=docker.io/$USER/eureka --set image.tag=$TAG

helm upgrade --install payment helm/charts/payment-service -n sit -f helm/env/values-sit.yaml   --set image.repository=docker.io/$USER/payment-service --set image.tag=$TAG

helm upgrade --install loan helm/charts/loan-service -n sit -f helm/env/values-sit.yaml   --set image.repository=docker.io/$USER/loan-service --set image.tag=$TAG

helm upgrade --install gateway helm/charts/api-gateway -n sit -f helm/env/values-sit.yaml   --set image.repository=docker.io/$USER/api-gateway --set image.tag=$TAG   --set ingress.enabled=true --set ingress.hosts[0].host=gateway.sit.local --set ingress.hosts[0].paths[0].path=/
echo "Deployed to namespace sit (env sit)"
