# Pipeline Tasks

Collection of Concourse pipeline task that can be reused.

* [`bump-blob.yml`](docs/bump-blob.md): Bump a Blob in a Bosh release
* [`create-release.yml`](docs/create-release.md): Create a Bosh Release
* [`package-cached-buildpack.yml`](docs/package-cached-buildpack.md): Package a
  buildpack (expect for **java** and **php**) with all the dependencies cached.
  * `package-cached-java-buildpack.yml`: Package the **java** buildpack with all
  the dependencies cached. See [`package-cached-buildpack.yml`](docs/package-cached-buildpack.md)
  * `package-cached-php-buildpack.yml`: Package the **php** buildpack with all
  the dependencies cached. See [`package-cached-buildpack.yml`](docs/package-cached-buildpack.md)
