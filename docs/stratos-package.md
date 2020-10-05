# `stratos-package.yml`

Package the Stratos UI for use in an offline mode. Also can be run with the standard build `binary-buildpack` instead of the `stratos-buildpack`.

## Inputs

* `pipeline-tasks`: This repository.
* `stratos-release`: The [github-release-resource](https://github.com/concourse/github-release-resource) of Stratos.

## Outputs

* `stratos`: Directory containing the package Stratos UI zip file `stratos-<version>.zip`.
* `notification`: Directory containing a notification message file called `message.txt` with the notification content.
