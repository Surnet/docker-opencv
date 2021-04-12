# docker-opencv

This repo contains scripts to create docker images which will be available in multiple variants.

The purpose is to publish docker images with a working opencv installation and keep them as small as possible while delivering all functions.
The opencv version on node shall work for [opencv4nodejs](https://www.npmjs.com/package/opencv4nodejs).

## Naming

The published images follow a naming convention.

### Image name

The image name follows the format:

`surnet/<os>-<base>-opencv` or `surnet/<os/base>-opencv`

- `<os>` matches the underlaying os.
- `<base>` matches the used base image.
- `<os/base>` matches the used base image if the os and base image are the same.

e.g. `surnet/alpine-node-opencv` or `surnet/alpine-opencv`

### Tags

The tags represent version numbers which follow the format:

`<1>-<2>`

- `<1>` matches the version of the base image.
- `<2>` matches the opencv version.

e.g. `14.16.0-4.5.1`

## Available Images

### surnet/alpine-opencv

[![Docker Stars](https://img.shields.io/docker/stars/surnet/alpine-opencv.svg)](https://hub.docker.com/r/surnet/alpine-opencv/)
[![Docker Pulls](https://img.shields.io/docker/pulls/surnet/alpine-opencv.svg)](https://hub.docker.com/r/surnet/alpine-opencv/)

This image can be used as a base for your project.

For a list of available versions please see the page on [Docker Hub](https://hub.docker.com/r/surnet/alpine-opencv/tags/) or the [GitHub Container Registry](https://github.com/orgs/Surnet/packages/container/package/alpine-opencv).
If a version you would like is missing please open an issue on this repo.

#### Docker Hub

```yaml
FROM surnet/alpine-opencv:<version>
```

#### GitHub Container Registry

```yaml
FROM ghcr.io/surnet/alpine-opencv:<version>
```

### surnet/alpine-node-opencv

[![Docker Stars](https://img.shields.io/docker/stars/surnet/alpine-node-opencv.svg)](https://hub.docker.com/r/surnet/alpine-node-opencv/)
[![Docker Pulls](https://img.shields.io/docker/pulls/surnet/alpine-node-opencv.svg)](https://hub.docker.com/r/surnet/alpine-node-opencv/)

This image can be used as a base for your NodeJS project.
The opencv version is compatible and configured for use with [opencv4nodejs](https://www.npmjs.com/package/opencv4nodejs).

For a list of available versions please see the page on [Docker Hub](https://hub.docker.com/r/surnet/alpine-node-opencv/tags/) or the [GitHub Container Registry](https://github.com/orgs/Surnet/packages/container/package/alpine-node-opencv).
If a version you would like is missing please open an issue on this repo.

#### Docker Hub

```yaml
FROM surnet/alpine-node-opencv:<version>
```

#### GitHub Container Registry

```yaml
FROM ghcr.io/surnet/alpine-node-opencv:<version>
```

## Contribute

Please feel free to open a issue or pull request with suggestions.

Keep in mind that the build process of these container takes some time.

## Credits

Based upon the following repos/inputs:
- https://github.com/Surnet/docker-wkhtmltopdf
- https://github.com/dkimg/opencv
