# `copy-github-release.yml`

Copy Github release artifacts to a subdirectory of output folder; this subdirectory
will be named with the version of the release. All files provided by the release
will be copied with the release notes except:

* Standard Github release resource files:
  * tag
  * version
  * commit_sha
  * url
* Optional Github release resource files:
  * source.tar.gz
  * source.zip

## Inputs:

* `pipeline-tasks`: This repository.
* `release`: The Github release to copy the content.

## Outputs:

* `artifacts`: Directory containing the copied artifacts.

## Parameters:

* `SKIP_VERSION_SUBDIR`: If set (to anything other than blank) will not create a
  subdirectory with the version. The `RELEASE_NOTE_PREFIX` should also be set in
  this case since the release notes could override an exiting file.
* `RELEASE_NOTE_PREFIX`: Release note prefix when `SKIP_VERSION_SUBDIR` is used,
  in this case the release notes will be `<RELEASE_NOTE_PREFIX>-<VERSION>-release.md`
  instead of `release.md`.
