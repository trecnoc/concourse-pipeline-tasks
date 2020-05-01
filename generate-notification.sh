#!/usr/bin/env bash

set -e
set -o pipefail

INPUT=content-input
NOTIFICATION=notification

case ${INPUT_TYPE} in
  bosh_io_release )
    printf "Generating notification for a bosh.io release\n"

    VERSION=$(cat ${INPUT}/version)

    tar -xzf ${INPUT}/*.tgz release.MF
    RELEASE=$(egrep "^name:" release.MF | cut -d " " -f 2 | xargs)

    MESSAGE="Successfully mirrored version ${VERSION} of the ${RELEASE} bosh release"
    ;;
  bosh_io_stemcell )
    printf "Generating notification for a bosh.io stemcell\n"

    VERSION=$(cat ${INPUT}/version)

    tar -xzf ${INPUT}/*.tgz stemcell.MF
    STEMCELL=$(egrep "^name:" stemcell.MF | cut -d " " -f 2 | xargs)

    MESSAGE="Successfully mirrored version ${VERSION} of the ${STEMCELL} bosh stemcell"
    ;;
  minio_cli)
    printf "Generating notification for the MinIO CLI\n"

    VERSION=$(cat ${INPUT}/version)

    MESSAGE="Successfully mirrored version ${VERSION} of the minio cli"
    ;;
  *)
    printf "Unknown input type\n"
    MESSAGE=""
    ;;
esac

cat << EOF > ${NOTIFICATION}/message.txt
${MESSAGE}
EOF
