@echo off
setlocal
if "%1"=="" (echo Usage: build_all.bat <docker_user> [tag] & exit /b 1)
set USER=%1
set TAG=%2
if "%TAG%"=="" set TAG=latest
mvn -q -DskipTests clean package
docker build -t %USER%/eureka:%TAG% -f day02-eureka-discovery/eureka-server/Dockerfile day02-eureka-discovery/eureka-server
docker build -t %USER%/api-gateway:%TAG% -f day03-api-gateway/api-gateway/Dockerfile day03-api-gateway/api-gateway
docker build -t %USER%/payment-service:%TAG% -f day04-loadbalancer/payment-service/Dockerfile day04-loadbalancer/payment-service
docker build -t %USER%/loan-service:%TAG% -f day04-loadbalancer/loan-service/Dockerfile day04-loadbalancer/loan-service
