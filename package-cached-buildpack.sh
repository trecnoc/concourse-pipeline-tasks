#!/usr/bin/env bash

set -e
set -o pipefail

GITHUB_RELEASE=buildpack-release
BUILDPACK_OUTPUT=buildpack

DEFAULT_STACK=cflinuxfs3
BUILD_FOLDER=buildpack-source

if [[ -z ${STACK} ]]; then
  STACK=${DEFAULT_STACK}
fi

BUILDPACK_VERSION=$(cat ${GITHUB_RELEASE}/version)

mkdir -p ${BUILD_FOLDER}
tar -xzf ${GITHUB_RELEASE}/source.tar.gz --strip-components=1 -C ${BUILD_FOLDER}

pushd ${BUILD_FOLDER} > /dev/null

if [[ -f manifest.yml ]]; then
  BUILDPACK=$(egrep "^language:" manifest.yml | cut -d " " -f 2 | xargs)
else
  # Java buildpack source doesn't have a manifest.yml file.
  # This should be the only buildpack with this case
  BUILDPACK=java
fi

printf "Packaging version '%s' of the '%s' buildpack with cached dependencies for stack '%s'\n\n" ${BUILDPACK_VERSION} ${BUILDPACK} ${STACK}

if [[ "${BUILDPACK}" == "java" ]]; then
  bundle install
  bundle exec rake clean package OFFLINE=true PINNED=true

  # Move buildpack one level up
  mv build/*.zip .
elif [[ "${BUILDPACK}" == "php" ]]; then
  BUNDLE_GEMFILE=cf.Gemfile bundle
  BUNDLE_GEMFILE=cf.Gemfile bundle exec buildpack-packager --cached --stack ${STACK}
else
  go get github.com/cloudfoundry/libbuildpack/packager/buildpack-packager
  go install github.com/cloudfoundry/libbuildpack/packager/buildpack-packager

  rm -f *.zip
  source .envrc
  buildpack-packager summary
  buildpack-packager build --cached --stack ${STACK}
fi

popd > /dev/null

mv ${BUILD_FOLDER}/*.zip ${BUILDPACK_OUTPUT}

if [[ -f ${GITHUB_RELEASE}/body ]]; then
  printf "release notes saved as ${BUILDPACK}_buildpack-cached-v${BUILDPACK_VERSION}-release.md"
  cp ${GITHUB_RELEASE}/body ${BUILDPACK_OUTPUT}/${BUILDPACK}_buildpack-cached-v${BUILDPACK_VERSION}-release.md
else
  printf "WARNING: no release notes provided with the release"
fi
