#!/usr/bin/env bash
set -euo pipefail
USER=${1:?docker user required}
TAG=${2:-latest}
mvn -q -DskipTests clean package
docker build -t $USER/eureka:$TAG       -f day02-eureka-discovery/eureka-server/Dockerfile day02-eureka-discovery/eureka-server
docker build -t $USER/api-gateway:$TAG  -f day03-api-gateway/api-gateway/Dockerfile      day03-api-gateway/api-gateway
docker build -t $USER/payment-service:$TAG -f day04-loadbalancer/payment-service/Dockerfile day04-loadbalancer/payment-service
docker build -t $USER/loan-service:$TAG    -f day04-loadbalancer/loan-service/Dockerfile    day04-loadbalancer/loan-service
