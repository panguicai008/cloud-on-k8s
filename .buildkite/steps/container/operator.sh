#!/usr/bin/env bash
set -euo pipefail

source .buildkite/steps/container/lib.sh
# shellcheck disable=SC1091
source .env

REGISTRY=docker.elastic.co
NAMESPACE=${REGISTRY_NAMESPACE}
NAME=eck-operator-ci

# TODO: dry
TAG=$(get_tag)
VERSION=$(cat VERSION)
SNAPSHOT=true
GO_LDFLAGS="-X github.com/elastic/cloud-on-k8s/pkg/about.version=${VERSION} \
 -X github.com/elastic/cloud-on-k8s/pkg/about.buildHash=${TAG} \
 -X github.com/elastic/cloud-on-k8s/pkg/about.buildDate=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
 -X github.com/elastic/cloud-on-k8s/pkg/about.buildSnapshot=${SNAPSHOT}"

NAMESPACE=eck-dev # TEMPORARY - testing

img="${REGISTRY}/${NAMESPACE}/${NAME}:$(get_tag)"

registry_login

buildah bud \
   --platform "${BUILD_PLATFORM}" \
  --build-arg GO_LDFLAGS="${GO_LDFLAGS}" \
  --build-arg GO_TAGS="${GO_TAGS}" \
  --build-arg VERSION="${VERSION}" \
  -t "${img}"

buildah push "${img}"
