#!/bin/bash
#
# Build and export Debian 12 + ROCm 7.0 + Python 3.10 + onnxruntime image
# This base image is used by all Triton build stages
#

set -e

IMAGE_NAME="local/rocm7.1.1_debian12_ort1.23_py310"
DOCKERFILE="Dockerfile.debian12_rocm7.1_onnxruntime"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

echo "========================================"
echo "Building Debian 12 ROCm Base Image"
echo "========================================"
echo "Image: ${IMAGE_NAME}"
echo "Dockerfile: ${DOCKERFILE}"
echo ""

# Build the base image
echo "Building Docker image..."
docker build -t "${IMAGE_NAME}" -f "${DOCKERFILE}" .

echo ""
echo "Verifying image..."
docker images | grep "${IMAGE_NAME}"

echo ""
echo "========================================"
echo "✓ Base image build complete!"
echo "========================================"
echo ""
echo "Image tagged as: ${IMAGE_NAME}"
echo ""
echo "To use in builds:"
echo "  ./build.py --enable-rocm --linux-distro=debian ..."
echo ""

