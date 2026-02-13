#!/bin/bash
#
# Build Debian 12 + ROCm 7.2 vLLM image

set -e

# Get script directory and run from it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

# --- Step 1: Build local/debian12_rocm7.2 ---
echo "========================================"
echo "Building local/debian12_rocm7.2"
echo "========================================"
docker build -t local/debian12_rocm7.2 -f Dockerfile.debian12_rocm7.2 .
echo ""

docker images | grep -E "local/debian12_rocm7.2" || true