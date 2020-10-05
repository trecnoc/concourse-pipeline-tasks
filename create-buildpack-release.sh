#!/usr/bin/env bash

set -e
set -o pipefail

# Inputs
BUILDPACK_RELEASE=buildpack-release
BUILDPACK_BOSH_REPO=buildpack-bosh-repository
BUILDPACK_CACHED=cached-buildpack

# Output
RELEASE_OUTPUT=bosh-release
NOTIFICATION_OUTPUT=notification-output

BUILDPACK_VERSION=$(cat ${BUILDPACK_RELEASE}/version)
BLOB=$(find ${BUILDPACK_CACHED} -type f -name *.zip -printf "%f")

pushd ${BUILDPACK_BOSH_REPO} >/dev/null

bosh add-blob ../${BUILDPACK_CACHED}/${BLOB} ${BLOB_PATH}/${BLOB}
bosh upload-blobs

RELEASE_NAME=$(egrep "^(final_)?name:" config/final.yml | cut -d " " -f 2 | xargs)

git config --global user.email not-pushed@irrelevant
git config --global user.name "Not Push, so irrelevant"
git add config/blobs.yml
git commit -m "Make bosh create-release happy"

bosh create-release --final --version="${BUILDPACK_VERSION}" --tarball ../${RELEASE_OUTPUT}/${RELEASE_NAME}-release-${BUILDPACK_VERSION}.tgz

popd > /dev/null

if [[ -f ${BUILDPACK_RELEASE}/body ]]; then
  printf "release notes saved as ${RELEASE_NAME}-release-${BUILDPACK_VERSION}.md"
  cp ${BUILDPACK_RELEASE}/body ${RELEASE_OUTPUT}/${RELEASE_NAME}-release-${BUILDPACK_VERSION}.md
else
  printf "WARNING: no release notes provided with the release"
fi

cat << EOF > notification-output/message.txt
Successfully built ${RELEASE_NAME} Bosh release version ${BUILDPACK_VERSION}
EOF
