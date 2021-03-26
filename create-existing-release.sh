#!/usr/bin/env bash

set -e
set -o pipefail

VERSION=$(cat github-release-input/version)

BUILD_FOLDER=source
mkdir -p ${BUILD_FOLDER}

tar -xzf github-release-input/source.tar.gz --strip-components=1 -C ${BUILD_FOLDER}

pushd ${BUILD_FOLDER} >/dev/null
bosh create-release --final --version="${VERSION}+CUSTOM" --tarball ../release/${RELEASE_NAME}-${VERSION}.tgz
popd >/dev/null

if [[ -f github-release-input/body ]]; then
  printf "release notes saved as ${RELEASE_NAME}-${VERSION}.md"
  cp github-release-input/body release/${RELEASE_NAME}-${VERSION}.md
else
  printf "WARNING: no release notes provided with the release"
fi

cat <<EOF >notification/message.txt
Successfully built ${RELEASE_NAME} version ${VERSION}
EOF
