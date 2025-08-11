#!/usr/bin/env bash
set -euo pipefail

IMAGE_PREFIX="${1:-kienvt123456}"
APP_VERSION="${2:-v1.0.0}"

modules=(
  "day02-eureka-discovery/eureka-server"
  "day03-config-server/config-server"
  # thêm các module khác...
)

for m in "${modules[@]}"; do
  echo ">>> Building Maven module: $m"
  ( cd "$m" && mvn clean package -DskipTests )
done

# Ví dụ build Docker cho từng module (nếu có Dockerfile ở chính thư mục module)
for m in "${modules[@]}"; do
  NAME="$(basename "$m")"
  echo ">>> Building Docker image for $NAME"
  docker build -t "${IMAGE_PREFIX}/${NAME}:${APP_VERSION}" -f "$m/Dockerfile" "$m"
done
