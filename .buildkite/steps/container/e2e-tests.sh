#!/usr/bin/env bash
set -euo pipefail

source .buildkite/steps/container/lib.sh
# shellcheck disable=SC1091
source .env

REGISTRY=docker.elastic.co
NAMESPACE=${E2E_REGISTRY_NAMESPACE} # .env
NAME=eck-e2e-tests                  # Makefile

NAMESPACE=eck-dev # TEMPORARY - testing

img="${REGISTRY}/${NAMESPACE}/${NAME}:$(get_tag)"

registry_login

buildah bud \
  --platform "${BUILD_PLATFORM}" \
  --build-arg E2E_JSON="${E2E_JSON}" \
  --build-arg E2E_TAGS="e2e ${GO_TAGS}" \
  -f test/e2e/Dockerfile \
  -t "${img}"

buildah push "${img}"
