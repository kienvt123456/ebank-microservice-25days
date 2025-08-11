@echo off
setlocal
if "%1"=="" (echo Usage: push_all.bat <docker_user> [tag] & exit /b 1)
set USER=%1
set TAG=%2
if "%TAG%"=="" set TAG=latest
docker push %USER%/eureka:%TAG%
docker push %USER%/api-gateway:%TAG%
docker push %USER%/payment-service:%TAG%
docker push %USER%/loan-service:%TAG%
