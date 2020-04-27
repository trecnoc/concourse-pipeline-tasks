# `package-cached-buildpack.yml`

Package a buildpack with all the dependencies cached. For **java** use
`package-cached-java-buildpack.yml` and for **php** use `package-cached-php-buildpack.yml`.

## Inputs:

* `pipeline-tasks`: This repository.
* `buildpack-release`: The Github release of a buildpack.

## Outputs:

* `buildpack`: Directory containing the zipped buildpack.
* `notification-output`: Directory containing a notification message file called
  `message.txt`. This file will have the following message `Successfully packaged cached version ${BUILDPACK_VERSION} of the ${BUILDPACK} buildpack`

## Parameters:

* `STACK`: __OPTIONAL.__ Stack to package the buildpack for, if not specified
  defaults to `cflinusfs3`
