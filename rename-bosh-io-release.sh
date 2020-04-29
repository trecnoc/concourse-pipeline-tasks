#!/usr/bin/env bash

set -e
set -o pipefail

RELEASE_INPUT=release-input
RELEASE_OUTPUT=release-output
NOTIFICATION_OUTPUT=notification-output

VERSION=$(cat ${RELEASE_INPUT}/version)

tar -xzf ${RELEASE_INPUT}/release.tgz release.MF
RELEASE=$(egrep "^name:" release.MF | cut -d " " -f 2 | xargs)

printf "Renaming bosh.io release for '%s' version '%s'" ${RELEASE} ${VERSION}

cp ${RELEASE_INPUT}/release.tgz ${RELEASE_OUTPUT}/${RELEASE}-release-${VERSION}.tgz
