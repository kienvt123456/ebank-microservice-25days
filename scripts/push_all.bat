@echo off
set DOCKER_USER=%1
set IMAGE_TAG=%2
if "%DOCKER_USER%"=="" (
  echo Usage: scripts\push_all.bat ^<docker_user^> ^<tag^>
  exit /b 1
)
if "%IMAGE_TAG%"=="" set IMAGE_TAG=latest

docker push %DOCKER_USER%/eureka:%IMAGE_TAG%
docker push %DOCKER_USER%/api-gateway:%IMAGE_TAG%
docker push %DOCKER_USER%/payment-service:%IMAGE_TAG%
docker push %DOCKER_USER%/loan-service:%IMAGE_TAG%
