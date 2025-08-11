#!/usr/bin/env bash
set -euo pipefail
NS=dev
USER=${1:-your-docker-user}
TAG=${2:-latest}

kubectl create ns dev || true

helm upgrade --install eureka helm/charts/eureka -n dev -f helm/env/values-dev.yaml   --set image.repository=docker.io/$USER/eureka --set image.tag=$TAG

helm upgrade --install payment helm/charts/payment-service -n dev -f helm/env/values-dev.yaml   --set image.repository=docker.io/$USER/payment-service --set image.tag=$TAG

helm upgrade --install loan helm/charts/loan-service -n dev -f helm/env/values-dev.yaml   --set image.repository=docker.io/$USER/loan-service --set image.tag=$TAG

helm upgrade --install gateway helm/charts/api-gateway -n dev -f helm/env/values-dev.yaml   --set image.repository=docker.io/$USER/api-gateway --set image.tag=$TAG   --set ingress.enabled=true --set ingress.hosts[0].host=gateway.dev.local --set ingress.hosts[0].paths[0].path=/
echo "Deployed to namespace dev (env dev)"
