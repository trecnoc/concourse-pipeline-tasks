#!/usr/bin/env bash

set -e
set -o pipefail

INPUT=content-input
NOTIFICATION=notification

if [[ -f ${INPUT}/version ]]; then
  VERSION=$(cat ${INPUT}/version)
elif [[ -f ${INPUT}/.git/ref ]]; then
  VERSION=$(cat ${INPUT}/.git/ref)
fi

case ${INPUT_TYPE} in
  bosh_io_release)
    printf "Generating notification for a bosh.io release\n"

    tar -xzf ${INPUT}/*.tgz release.MF
    RELEASE=$(egrep "^name:" release.MF | cut -d " " -f 2 | xargs)

    MESSAGE="Successfully mirrored version ${VERSION} of the ${RELEASE} bosh release"
    ;;
  bosh_io_stemcell)
    printf "Generating notification for a bosh.io stemcell\n"

    tar -xzf ${INPUT}/*.tgz stemcell.MF
    STEMCELL=$(egrep "^name:" stemcell.MF | cut -d " " -f 2 | xargs)

    MESSAGE="Successfully mirrored version ${VERSION} of the ${STEMCELL} bosh stemcell"
    ;;
  concourse)
    printf "Generating notification for the Concourse Bosh Deployment\n"
    MESSAGE="Successfully mirrored version ${VERSION} of the concourse bosh deployment"
    ;;
  doomsday_bosh)
    printf "Generating notification for the Doomsday Bosh Release\n"
    MESSAGE="Successfully mirrored version ${VERSION} of the doomsday bosh release"
    ;;
  doomsday_cli)
    printf "Generating notification for the Doomsday CLI\n"
    MESSAGE="Successfully mirrored version ${VERSION} of the doomsday cli"
    ;;
  minio_cli)
    printf "Generating notification for the MinIO CLI\n"
    MESSAGE="Successfully mirrored version ${VERSION} of the minio cli"
    ;;
  *)
    printf "Unknown input type\n"
    MESSAGE="Notification for unknown type"
    ;;
esac

cat << EOF > ${NOTIFICATION}/message.txt
${MESSAGE}
EOF
