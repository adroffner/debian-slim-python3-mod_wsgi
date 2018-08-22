#! /bin/bash
#
# Docker Image: Debian Slim - Python 3 and Apache/MOD_WSGI
# =============================================================================
# Run docker image in a new container.
# This is NOT run in "detached" (-d) mode.
# =============================================================================

REGISTRY="dockercentral.it.att.com:5100"
NAMESPACE="com.att.dev.argos"
IMAGE_NAME="debian-slim-python3-mod_wsgi"
TAG="3.6.6"

FULL_IMAGE_NAME="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

docker run --rm -ti -p 8001:8001 $FULL_IMAGE_NAME
