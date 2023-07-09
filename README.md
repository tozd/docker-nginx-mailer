# tozd/nginx-mailer

<https://gitlab.com/tozd/docker/nginx-mailer>

Available as:

- [`tozd/nginx-mailer`](https://hub.docker.com/r/tozd/nginx-mailer)
- [`registry.gitlab.com/tozd/docker/nginx-mailer`](https://gitlab.com/tozd/docker/nginx-mailer/container_registry)

## Image inheritance

[`tozd/base`](https://gitlab.com/tozd/docker/base) ← [`tozd/dinit`](https://gitlab.com/tozd/docker/dinit) ← [`tozd/nginx`](https://gitlab.com/tozd/docker/nginx) ← `tozd/nginx-mailer`

See also [`tozd/mailer`](https://gitlab.com/tozd/docker/mailer).

## Tags

- `ubuntu-trusty`: nullmailer 1.11
- `ubuntu-xenial`: nullmailer 1.13
- `ubuntu-bionic`: nullmailer 2.1
- `ubuntu-focal`: nullmailer 2.2
- `ubuntu-jammy`: nullmailer 2.2

## Volumes

- `/var/log/nullmailer`: Log files when `LOG_TO_STDOUT` is not set to `1`.
- `/var/spool/nullmailer`: Work files (e.g., queue). Persist this volume to not lose state.

## Variables

- `ADMINADDR`: If set, all e-mails to system users inside a container are send to this address.
- `REMOTES`: E-mail relay server the container should be using to send e-mails.
- `LOG_TO_STDOUT`: If set to `1` output logs to stdout (retrievable using `docker logs`) instead of log volumes.

## Description

Image extending [tozd/nginx](https://gitlab.com/tozd/docker/nginx) image with a simple e-mailing out of the container
using [nullmailer](http://untroubled.org/nullmailer/).

## GitHub mirror

There is also a [read-only GitHub mirror available](https://github.com/tozd/docker-nginx-mailer),
if you need to fork the project there.
