#!/usr/bin/env bash

set -e
set -o pipefail

GITHUB_RELEASE=mc-release
CLI_OUTPUT=mc-cli

MC_CLI_LINUX_URL="https://dl.minio.io/client/mc/release/linux-amd64/mc"
MC_CLI_WIN_URL="https://dl.minio.io/client/mc/release/windows-amd64/mc.exe"

VERSION=$(cat ${GITHUB_RELEASE}/version)
mkdir -p ${CLI_OUTPUT}/${VERSION}

printf "Downloading MC CLI client for version '%s'\n\n" ${VERSION}

printf "Linux client\n"
curl --progress-bar --retry 5 -Lo ${CLI_OUTPUT}/${VERSION}/mc ${MC_CLI_LINUX_URL}
printf "Windows client\n"
curl --progress-bar --retry 5 -Lo ${CLI_OUTPUT}/${VERSION}/mc.exe ${MC_CLI_WIN_URL}

if [[ -f ${GITHUB_RELEASE}/body ]]; then
  printf "Adding MC CLI release notes\n"
  cp ${GITHUB_RELEASE}/body ${CLI_OUTPUT}/${VERSION}/release.md
fi
