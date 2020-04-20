# Pipeline Tasks

Collection of Concourse pipeline task that can be reused.

### `bump-blob.yml`: Bump a Blob in a Bosh release

Updates a Blob in a Bosh release Git repository.

#### Inputs:

* `pipeline-tasks`: This repository.
* `blob-input`: The Blob artifact to replace in the Bosh release, will find one
  file not named: SHA, VERSION or URL.
* `repository-input`: The Bosh release Git repository to bump the blob for.

#### Outputs:

* `repository-output`: The updated Bosh release Git repository.

#### Parameters:

* `CI_BOT_USER`: Username for the Git commit.
* `CI_BOT_EMAIL`: Email address for the Git commit.
* `ACCESS_KEY_ID`: Blobstore Access Key ID.
* `SECRET_KEY`: Blobstore Secret Key.
* `BLOB_NAME`: Blob Name, new blob will be uploaded has `${BLOB_NAME}/${BLOB}`
   where `${BLOB}` will be the filename found in the `blob-input`.
* `BLOB_REGEX`: Blob Regular Expression for finding the correct blob to update.

### `create-release.yml`: Create a Bosh Release

Create a final Bosh release and export the resulting release.

#### Inputs:

* `pipeline-tasks`: This repository.
* `repository-input`: The Bosh release Git repository to create a release for.

#### Outputs:

* `repository-output`: The updated Bosh release Git repository.
* `release-tarball`: Directory containing the export Bosh release.
* `notification-output`: Directory containing a notification message file called
  `message.txt`. This file will have the following message `Successfully built
  ${RELEASE_NAME} Bosh release version ${RELEASE_VERSION}`

#### Parameters:

* `CI_BOT_USER`: Username for the Git commit.
* `CI_BOT_EMAIL`: Email address for the Git commit.
* `ACCESS_KEY_ID`: Blobstore Access Key ID.
* `SECRET_KEY`: Blobstore Secret Key.
