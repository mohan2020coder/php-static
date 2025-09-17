#!/bin/bash
set -e

# Check Docker is installed
if ! command -v docker &>/dev/null; then
  echo "Error: Docker is not installed or not in PATH."
  exit 1
fi

# Load PHP_VERSION from .env or fallback
if [ -f ./php-version.env ]; then
  source ./php-version.env
fi

PHP_VERSION=${PHP_VERSION:-8.2.12}
OUT_DIR="$(pwd)/output"
mkdir -p "$OUT_DIR"

echo "Building PHP static binary version: $PHP_VERSION"

docker build -t php-static-linux -f Dockerfile.linux --build-arg PHP_VERSION=$PHP_VERSION .

CID=$(docker create php-static-linux)

# Ensure container cleanup on exit
trap 'docker rm -f $CID > /dev/null 2>&1 || true' EXIT

docker cp $CID:/php-static "$OUT_DIR/php-static-linux-$PHP_VERSION"

docker rm $CID
trap - EXIT

chmod +x "$OUT_DIR/php-static-linux-$PHP_VERSION"

echo "Build complete. Binary is at $OUT_DIR/php-static-linux-$PHP_VERSION"
