#!/usr/bin/env bash

set -e
set -o pipefail

printf "Bumping Blob '%s' matching '%s'\n\n" ${BLOB_NAME} ${BLOB_REGEX}

LATEST_VERSION=$(cat blob-input/version)
BLOB=$(find blob-input -type f \( ! -name sha ! -name url ! -name version \) -printf "%f")

cp -r repository-input/. repository-output
pushd repository-output > /dev/null

OLD_BLOB_PATH=$(bosh blobs --column=path | egrep "${BLOB_REGEX}" || true)
if [[ ! -z ${OLD_BLOB_PATH} ]]; then
  OLD_VERSION=$([[ "${OLD_BLOB_PATH}" =~ ${BLOB_REGEX} ]] && echo ${BASH_REMATCH[1]})
else
  OLD_VERSION="0"
fi

if [[ "${OLD_VERSION}" != "${LATEST_VERSION}" ]]; then
  printf "Version bump: '%s' to '%s'\n" "${OLD_VERSION}" "${LATEST_VERSION}"
  printf "New blob    : %s\n" ${BLOB}

  cat << EOF > config/private.yml
blobstore:
  options:
    access_key_id: "${ACCESS_KEY_ID}"
    secret_access_key: "${SECRET_KEY}"
EOF

  if [[ ! -z ${OLD_BLOB_PATH} ]]; then
    printf "Old blob    : %s\n\n" ${OLD_BLOB_PATH}
    bosh remove-blob ${OLD_BLOB_PATH}
  else
    printf "Old blob    : not found, nothing to remove\n\n"
  fi

  bosh add-blob ../blob-input/${BLOB} ${BLOB_NAME}/${BLOB}
  bosh upload-blobs

  git config --global user.email ${CI_BOT_EMAIL}
  git config --global user.name ${CI_BOT_USER}
  git add config/blobs.yml
  git status
  git commit -m "Bump ${BLOB_NAME} to ${LATEST_VERSION}"
else
  printf "Release has latest blob version (%s), skipping bump." ${LATEST_VERSION}
fi
