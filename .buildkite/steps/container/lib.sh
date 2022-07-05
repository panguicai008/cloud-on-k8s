#!/usr/bin/env bash
set -euo pipefail

get_tag() {
  git config --global --add safe.directory "$(pwd)"
  tag=$(git rev-parse --short=8 --verify HEAD)
  echo "$(cat VERSION)-${tag}"
}

# registry_login connects to a container image registry using credentials retrieved from Vault.
#
# @REGISTRY
#
registry_login() {
  username=$(vault read -field=username secret/ci/elastic-cloud-on-k8s/docker-registry)
  password=$(vault read -field=password secret/ci/elastic-cloud-on-k8s/docker-registry)

  buildah login --username="${username}" --password="${password}" "${REGISTRY}"
}
