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
    LABEL="${RELEASE} bosh release"
    ;;
  bosh_io_stemcell)
    printf "Generating notification for a bosh.io stemcell\n"

    tar -xzf ${INPUT}/*.tgz stemcell.MF
    STEMCELL=$(egrep "^name:" stemcell.MF | cut -d " " -f 2 | xargs)
    LABEL="${STEMCELL} bosh stemcell"
    ;;
  generic)
    printf "Generating a notification with label '%s'" "${LABEL}"
    ;;
  *)
    printf "Unknown input type\n"
    LABEL="<WARNING unknown type>"
    ;;
esac

cat << EOF > ${NOTIFICATION}/message.txt
Successfully mirrored version ${VERSION} of the ${LABEL}
EOF
