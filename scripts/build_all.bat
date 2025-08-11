@echo off
setlocal enabledelayedexpansion

REM ==== args ====
set DOCKER_USER=%1
set IMAGE_TAG=%2

if "%DOCKER_USER%"=="" (
  echo Usage: scripts\build_all.bat ^<docker_user^> ^<tag^>
  echo Example: scripts\build_all.bat kienvt123456 latest
  echo ERRORLEVEL=%ERRORLEVEL%
  if ERRORLEVEL 1 exit /b 1
)
if "%IMAGE_TAG%"=="" set IMAGE_TAG=latest

REM ==== sanity ====
where mvn >nul 2>&1 || (echo Maven not found in PATH & exit /b 1)
where docker >nul 2>&1 || (echo Docker CLI not found in PATH & exit /b 1)

echo.
echo === Build Maven projects ===

REM (1) Day 02 - Eureka Server
mvn -q -DskipTests -f day02-eureka-discovery\pom.xml -pl eureka-server -am clean package || exit /b 1

REM (2) Day 03 - API Gateway
mvn -q -DskipTests -f day03-api-gateway\pom.xml -pl api-gateway -am clean package || exit /b 1

REM (3) Day 04 - Payment & Loan (LoadBalancer variant)
mvn -q -DskipTests -f day04-loadbalancer\pom.xml -pl payment-service,loan-service -am clean package || exit /b 1

REM (4) (Optional) Day 01 - Config Server + clients (nếu muốn)
REM mvn -q -DskipTests -f day01-config-server\pom.xml -pl config-server,payment-service,loan-service -am clean package

echo.
echo === Build Docker images ===

REM Eureka
docker build -t %DOCKER_USER%/eureka:%IMAGE_TAG% -f day02-eureka-discovery\eureka-server\Dockerfile day02-eureka-discovery\eureka-server || exit /b 1

REM API Gateway
docker build -t %DOCKER_USER%/api-gateway:%IMAGE_TAG% -f day03-api-gateway\api-gateway\Dockerfile day03-api-gateway\api-gateway || exit /b 1

REM Payment (Day 04)
docker build -t %DOCKER_USER%/payment-service:%IMAGE_TAG% -f day04-loadbalancer\payment-service\Dockerfile day04-loadbalancer\payment-service || exit /b 1

REM Loan (Day 04)
docker build -t %DOCKER_USER%/loan-service:%IMAGE_TAG% -f day04-loadbalancer\loan-service\Dockerfile day04-loadbalancer\loan-service || exit /b 1

echo.
echo Done. Images built:
echo   %DOCKER_USER%/eureka:%IMAGE_TAG%
echo   %DOCKER_USER%/api-gateway:%IMAGE_TAG%
echo   %DOCKER_USER%/payment-service:%IMAGE_TAG%
echo   %DOCKER_USER%/loan-service:%IMAGE_TAG%

echo.
echo To push:
echo   scripts\\push_all.bat %DOCKER_USER% %IMAGE_TAG%

exit /b 0
