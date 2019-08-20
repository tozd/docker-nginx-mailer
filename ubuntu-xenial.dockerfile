FROM tozd/nginx:ubuntu-xenial

VOLUME /var/log/nullmailer

ENV ADMINADDR=
ENV REMOTES=

RUN apt-get update -q -q && \
 apt-get install nullmailer --no-install-recommends --yes --force-yes && \
 mkdir -m 700 /var/spool/nullmailer.orig && \
 mv /var/spool/nullmailer/* /var/spool/nullmailer.orig/ && \
 apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc /etc
