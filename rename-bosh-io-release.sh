#!/usr/bin/env bash

set -e
set -o pipefail

RELEASE_INPUT=release-input
RELEASE_OUTPUT=release-output
NOTIFICATION_OUTPUT=notification-output

VERSION=$(cat ${RELEASE_INPUT}/version)

tar -xzf ${RELEASE_INPUT}/release.tgz release.MF
RELEASE=$(egrep "^name:" release.MF | cut -d " " -f 2 | xargs)

printf "Renaming bosh.io release for '%s' version '%s'\n" ${RELEASE} ${VERSION}

if [[ -n ${CUSTOM_FILENAME_PREFIX} ]]; then
  printf "Overriding default filename '%s-release-%s.tgz' with '%s-%s.tgz'\n" ${RELEASE} ${VERSION} ${CUSTOM_FILENAME_PREFIX} ${VERSION}
  RELEASE_PREFIX=${CUSTOM_FILENAME_PREFIX}
else
  printf "Using default filename: '%s-release-%s.tgz'\n" ${RELEASE} ${VERSION}
  RELEASE_PREFIX=${RELEASE}-release
fi

cp ${RELEASE_INPUT}/release.tgz ${RELEASE_OUTPUT}/${RELEASE_PREFIX}-${VERSION}.tgz
