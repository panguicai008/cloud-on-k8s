#!/usr/bin/env bash

set -euo pipefail

source .buildkite/steps/container/lib.sh
source .env

REGISTRY=docker.elastic.co
TAG=$(get_current_sha1)
IMG=${REGISTRY}/${E2E_REGISTRY_NAMESPACE}/eck-e2e-tests:${TAG}


images_registry_login

buildah bud \
	--platform "${BUILD_PLATFORM}" \
	--build-arg E2E_JSON="${E2E_JSON}" \
	--build-arg E2E_TAGS="'e2e ${GO_TAGS}'" \
	-f test/e2e/Dockerfile \
	-t "${IMG}"

buildah push "${IMG}"
