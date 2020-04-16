#!/usr/bin/env bash

set -e
set -o pipefail

RELEASE_VERSION=$(cat version-input/version)

cp -r repository-input/. repository-output
cd repository-output

git config --global user.email ${CI_BOT_EMAIL}
git config --global user.name ${CI_BOT_USER}

cat << EOF > config/private.yml
blobstore:
  options:
    access_key_id: "$ACCESS_KEY_ID"
    secret_access_key: "$SECRET_KEY"
EOF

RELEASE_NAME=$(egrep "^(final_)?name:" config/final.yml | cut -d " " -f 2 | xargs)
bosh create-release --final --version="${RELEASE_VERSION}" --tarball ../release-tarball/${RELEASE_NAME}-release-${RELEASE_VERSION}.tgz

git add --all
git status
git commit -m "Create final release ${RELEASE_VERSION}"
git tag v${RELEASE_VERSION}
