#!/usr/bin/env bash

set -euo pipefail

get_current_sha1() {
	git config --global --add safe.directory $(pwd)
	git rev-parse --short=8 --verify HEAD
}

images_registry_login() {
	username=$(vault read -field=username secret/ci/elastic-cloud-on-k8s/docker-registry)
	password=$(vault read -field=password secret/ci/elastic-cloud-on-k8s/docker-registry)

	buildah login --username="${username}" --password="${password}" "${REGISTRY}"
}
