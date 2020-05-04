# `generate-notification.yml`

Generate a notification message to be used in for example a put step of a Slack
resource.

## Inputs:

* `pipeline-tasks`: This repository.
* `content-input`: An input which would contain the required information for generating
  the notification.

## Outputs:

* `notification`: Directory containing a notification message file called
  `message.txt` with the notification content.

## Parameters:

* `INPUT_TYPE`: Input type of the `content-input`. Support the following:
  * `bosh_io_release`: For a bosh-io-release-resource input
  * `bosh_io_stemcell`: For a bosh-io-stemcell-resource input
  * `concourse`: For a concourse deployment git repository input  
  * `doomsday_bosh`: For a Doomsday Bosh Github release input
  * `doomsday_cli`: For a Doomsday CLI Github release input
  * `minio_cli`: For a MinIO CLI Github release input
