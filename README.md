# Pipeline Tasks

Collection of Concourse pipeline task that can be reused.

* [`bump-blob.yml`](docs/bump-blob.md): Bump a Blob in a Bosh release
* [`copy-github-release.yml`](docs/copy-github-release.md): Copy a Github Release
  content (including the release notes)
* [`create-buildpack-release.yml`](docs/create-buildpack-release.md): Create a Bosh Release for buildpacks using the provided Cached buildpack
* [`create-release.yml`](docs/create-release.md): Create a Bosh Release
* [`download-releases-from-manifest.yml`](docs/download-releases-from-manifest.md):
  Download Bosh releases specified in a Bosh manifest.
* [`generate-mirrored-notification.yml`](docs/generate-mirrored-notification.md):
  Generate a mirrored notification message.
* [`package-cached-buildpack.yml`](docs/package-cached-buildpack.md): Package a
  buildpack (expect for **java** and **php**) with all the dependencies cached.
  * `package-cached-java-buildpack.yml`: Package the **java** buildpack with all
  the dependencies cached. See [`package-cached-buildpack.yml`](docs/package-cached-buildpack.md)
  * `package-cached-php-buildpack.yml`: Package the **php** buildpack with all
  the dependencies cached. See [`package-cached-buildpack.yml`](docs/package-cached-buildpack.md)
* [`rename-bosh-io-release.yml`](docs/rename-bosh-io-release.md): Rename a Bosh.io release
* [`stratos-package.yml`](docs/stratos-package.md): Package the Stratos UI with all dependencies
