# `create-buildpack-release.yml`

Create a Bosh release for buildpacks using the provided Cached buildpack zip.

## Inputs

* `pipeline-tasks`: This repository.
* `buildpack-release`: The Github Release of the Buildpack.
* `buildpack-bosh-repository`: The Git repository for the Bosh release of the Buildpack.
* `cached-buildpack`: Folder with the Cached Buildpack zip. Should have been built with one of `package-cached-buildpack.yml`, `package-cached-java-buildpack.yml` or `package-cached-php-buildpack.yml`

## Outputs

* `bosh-release`: Directory containing the export Bosh release and release notes (if provided).
* `notification-output`: Directory containing a notification message file called `message.txt`. This file will have the following message `Successfully built ${RELEASE_NAME} Bosh release version ${RELEASE_VERSION}`

## Parameters

* `BLOB_PATH`: The Blob Path for the Buildpack to be used in the Bosh release. Can be found in the Bosh Release repository of the buildpack in the packaging spec file.
