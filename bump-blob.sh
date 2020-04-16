#!/usr/bin/env bash

set -e
set -o pipefail

LATEST_VERSION=$(cat blob-input/version)
BLOB=$(find blob-input -type f \( ! -name sha ! -name url ! -name version \) -printf "%f")

cp -r repository-input/. repository-output

cd repository-output

OLD_BLOB_PATH=$(bosh blobs --column=path | egrep "${BLOB_REGEX}")
OLD_VERSION=$([[ "${OLD_BLOB_PATH}" =~ $BOSH_REGEX ]] && echo ${BASH_REMATCH[1]})

if [[ "${OLD_VERSION}" != "${LATEST_VERSION}" ]]; then
  git config --global user.email ${CI_BOT_EMAIL}
  git config --global user.name ${CI_BOT_USER}

  cat << EOF > config/private.yml
blobstore:
  options:
    access_key_id: "$ACCESS_KEY_ID"
    secret_access_key: "$SECRET_KEY"
EOF

  bosh remove-blob $OLD_BLOB_PATH
  bosh add-blob ../blob-input/${BLOB} ${BLOB_NAME}/${BLOB}
  bosh upload-blobs

  git add config/blobs.yml
  git status
  git commit -m "Bump ${BLOB_NAME} to ${LATEST_VERSION}"
else
  echo "Release has latest Blob version, skipping bump."
fi
