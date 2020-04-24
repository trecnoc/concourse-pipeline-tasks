# `create-release.yml`

Create a final Bosh release and export the resulting release.

## Inputs:

* `pipeline-tasks`: This repository.
* `repository-input`: The Bosh release Git repository to create a release for.

## Outputs:

* `repository-output`: The updated Bosh release Git repository.
* `release-tarball`: Directory containing the export Bosh release.
* `notification-output`: Directory containing a notification message file called
  `message.txt`. This file will have the following message `Successfully built
  ${RELEASE_NAME} Bosh release version ${RELEASE_VERSION}`

## Parameters:

* `CI_BOT_USER`: Username for the Git commit.
* `CI_BOT_EMAIL`: Email address for the Git commit.
* `ACCESS_KEY_ID`: Blobstore Access Key ID.
* `SECRET_KEY`: Blobstore Secret Key.
