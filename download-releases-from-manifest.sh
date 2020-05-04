#!/usr/bin/env bash

set -e
set -o pipefail

MANIFEST=manifest/manifest.yml
RELEASES_OUTPUT=releases

RELEASE_NAMES="$(bosh int ${MANIFEST} --path /releases | grep name | awk '{split($0,a,"name:"); print a[2]}')"
for RELEASE in ${RELEASE_NAMES}
do
  VERSION=$(bosh int ${MANIFEST} --path /releases/name=${RELEASE}/version)
  URL=$(bosh int ${MANIFEST} --path /releases/name=${RELEASE}/url)

  printf "Downloading Bosh release %s version %s\n" ${RELEASE} ${VERSION}
  (cd ${RELEASES_OUTPUT} && curl --progress-bar --retry 5 -LOJ ${URL})
done

pushd ${RELEASES_OUTPUT} > /dev/null

if test -e `echo *.tgz\?* | cut -d' ' -f1`
then
  for FILE in *.tgz\?*
  do
    printf "Removing curl parameters from filename: %s\n" ${FILE}
    mv "${FILE}" "${FILE%%\?*}"
  done
fi

popd > /dev/null
