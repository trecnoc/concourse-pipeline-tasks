#!/usr/bin/env bash

set -e
set -o pipefail

RELEASE_VERSION=$(cat version-input/version)

cp -r repository-input/. repository-output
cd repository-output

RELEASE_NAME=$(egrep "^(final_)?name:" config/final.yml | cut -d " " -f 2 | xargs)

printf "Creating '%s' Bosh release version '%s'\n\n" ${RELEASE_NAME} ${RELEASE_VERSION}

cat << EOF > config/private.yml
blobstore:
  options:
    access_key_id: "$ACCESS_KEY_ID"
    secret_access_key: "$SECRET_KEY"
EOF
bosh create-release --final --version="${RELEASE_VERSION}" --tarball ../release-tarball/${RELEASE_NAME}-release-${RELEASE_VERSION}.tgz

git config --global user.email ${CI_BOT_EMAIL}
git config --global user.name ${CI_BOT_USER}
git add --all
git status
git commit -m "Create final release ${RELEASE_VERSION}"
git tag v${RELEASE_VERSION}
