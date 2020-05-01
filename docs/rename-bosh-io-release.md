# `rename-bosh-io-release.yml`

Renames a Bosh.io release. When using the [bosh-io-release-resource](https://github.com/concourse/bosh-io-release-resource)
the downloaded release file will be called `release.tgz`. This task will inspect
the release content and rename the file <RELEASE_NAME>-release-<VERSION>.tgz.

The release name will come from the `release.MF` file inside the bosh release.

## Inputs:

* `pipeline-tasks`: This repository.
* `release-input`: The [bosh-io-release-resource](https://github.com/concourse/bosh-io-release-resource).

## Outputs:

* `release-output`: Directory containing the renamed release file.

## Parameters:

* `CUSTOM_FILENAME_PREFIX`: __OPTIONAL.__ Custom filename prefix to use when releases
  are not following <RELEASE_NAME>-release-<VERSION>.tgz, will instead be 
  <CUSTOM_FILENAME_PREFIX>-<VERSION>.tgz
