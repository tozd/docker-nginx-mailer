# tozd/nginx-mailer

<https://gitlab.com/tozd/docker/nginx-mailer>

Image extending [tozd/nginx](https://github.com/tozd/docker-nginx) image with a simple e-mailing out of the container
using [nullmailer](http://untroubled.org/nullmailer/).

You should set `ADMINADDR` environment variable to an e-mail address to which errors and failures should
go, and `REMOTES` to the e-mail relay server this image should be using to send e-mails.

There is no local delivery to system users inside the container. So no aliases and no delivery to `root` user,
for example.
