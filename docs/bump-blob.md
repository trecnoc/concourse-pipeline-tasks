# `bump-blob.yml`

Updates a Blob in a Bosh release Git repository.

## Inputs:

* `pipeline-tasks`: This repository.
* `blob-input`: The Blob artifact to replace in the Bosh release, will find one
  file not named: SHA, VERSION or URL.
* `repository-input`: The Bosh release Git repository to bump the blob for.

## Outputs:

* `repository-output`: The updated Bosh release Git repository.

## Parameters:

* `CI_BOT_USER`: Username for the Git commit.
* `CI_BOT_EMAIL`: Email address for the Git commit.
* `ACCESS_KEY_ID`: Blobstore Access Key ID.
* `SECRET_KEY`: Blobstore Secret Key.
* `BLOB_NAME`: Blob Name, new blob will be uploaded has `${BLOB_NAME}/${BLOB}`
   where `${BLOB}` will be the filename found in the `blob-input`.
* `BLOB_REGEX`: Blob Regular Expression for finding the correct blob to update.
