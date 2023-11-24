# brocksolutions/sqlcmd

This repository contains the Dockerfile for the `brocksolutions/sqlcmd` container image. This image provides the latest version of
Microsoft's `sqlcmd` (Go) tool.

Microsoft does not (yet) distribute an official `sqlcmd` container image, so this image is built by installing the `sqlcmd` tool
into a base Debian image.

## Available Tags

`latest`  - The latest version of the container.
`1.5.0.x` - A specific build of the image.

## Running the Container

The entrypoint in the container is set to the `/usr/bin/sqlcmd`. This means you can run the container in the same way you would run
the `sqlcmd` tool locally, and simply pass in any additional parameters you amy need.  For example:

``` powershell
docker run --rm brocksolutions/sqlcmd -S myserver -U myuser -P mypassword -Q "SELECT @@VERSION"
```
