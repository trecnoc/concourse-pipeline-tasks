# `generate-mirrored-notification.yml`

Generate a notification message to be used in a put step of a Slack
resource. The message will be `Successfully mirrored version ${VERSION} of the ${LABEL}`.

Supports extracting the version from the following files:
- `version`: Typical of some resource to include a version file.
- `.git\ref`: The git resource will include this file if a tag is cloned.

## Inputs:

* `pipeline-tasks`: This repository.
* `content-input`: An input which would contain the required information for generating
  the notification.

## Outputs:

* `notification`: Directory containing a notification message file called
  `message.txt` with the notification content.

## Parameters:

* `INPUT_TYPE`: Input type of the `content-input`. Support the following:
  * `bosh_io_release`: For a bosh-io-release-resource input, `LABEL` will be the
    bosh release name.
  * `bosh_io_stemcell`: For a bosh-io-stemcell-resource input, `LABEL` will be the
    bosh stemcell name.
  * `generic`: For a generic notification, requires the `LABEL` parameter.
* `LABEL`: The label added to the notification when `generic` `INPUT_TYPE` is used
  ignored in the other cases.
