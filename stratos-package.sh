#!/usr/bin/env bash

set -e
set -o pipefail

# Inputs
GITHUB_RELEASE=stratos-release

# Output
STRATOS_OUTPUT=stratos
NOTIFICATION_OUTPUT=notification-output

# Internal variables
CWD=$(pwd)
BUILD_FOLDER=stratos-source
CACHE_FOLDER=cache
STRATOS_VERSION=$(cat ${GITHUB_RELEASE}/version)

# Setup
mkdir -p ${BUILD_FOLDER}
mkdir -p ${CACHE_FOLDER}

# Get the Stratos source
tar -xzf ${GITHUB_RELEASE}/source.tar.gz --strip-components=1 -C ${BUILD_FOLDER}

pushd ${BUILD_FOLDER} >/dev/null

# Prebuild the UI
npm install --unsafe-perm
npm run prebuild-ui
rm -rf dist

# Build Stratos
bash -x deploy/cloud-foundry/build.sh "${CWD}/${BUILD_FOLDER}" "${CWD}/${CACHE_FOLDER}"

# Add Procfile for Binary Buildpack
echo "web: ./deploy/cloud-foundry/start.sh" >Procfile

# Cleanup
if [ -d "node_modules" ]; then
  rm -rf node_modules
fi
if [ -d "bower_components" ]; then
  rm -rf bower_components
fi

# Zip Stratos
zip -r "$CWD/${STRATOS_OUTPUT}/stratos-${STRATOS_VERSION}.zip" ./

popd >/dev/null

if [[ -f ${GITHUB_RELEASE}/body ]]; then
  printf "release notes saved as stratos-${STRATOS_VERSION}-release.md"
  cp ${GITHUB_RELEASE}/body ${STRATOS_OUTPUT}/stratos-${STRATOS_VERSION}-release.md
else
  printf "WARNING: no release notes provided with the release"
fi

cat <<EOF >${NOTIFICATION_OUTPUT}/message.txt
Successfully packaged Stratos version ${STRATOS_VERSION}
EOF
