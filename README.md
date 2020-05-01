# Pipeline Tasks

Collection of Concourse pipeline task that can be reused.

* [`bump-blob.yml`](docs/bump-blob.md): Bump a Blob in a Bosh release
* [`copy-github-release.yml`](docs/copy-github-release.md): Copy a Github Release
  content (including the release notes)
* [`create-release.yml`](docs/create-release.md): Create a Bosh Release
* [`download-mc-cli.yml`](docs/download-mc-cli.md): Download the MinIO CLI from it's
  Github release.
* [`generate-notification.yml`](docs/generate-notification.md): Generate a notification
  message.
* [`package-cached-buildpack.yml`](docs/package-cached-buildpack.md): Package a
  buildpack (expect for **java** and **php**) with all the dependencies cached.
  * `package-cached-java-buildpack.yml`: Package the **java** buildpack with all
  the dependencies cached. See [`package-cached-buildpack.yml`](docs/package-cached-buildpack.md)
  * `package-cached-php-buildpack.yml`: Package the **php** buildpack with all
  the dependencies cached. See [`package-cached-buildpack.yml`](docs/package-cached-buildpack.md)
* [`rename-bosh-io-release.yml`](docs/rename-bosh-io-release.md): Rename a Bosh.io release
