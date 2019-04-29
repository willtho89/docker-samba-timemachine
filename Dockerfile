FROM alpine:latest
MAINTAINER Thomas Willems <twillems@willtho.com>

RUN apk add --update \
    avahi \
    samba-common-tools \
    samba-client \
    samba-server \
    supervisor \
    && sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf \
    && rm -rf /var/cache/apk/* \
    && rm /etc/avahi/services/*


COPY setup.sh template_quota /tmp/
COPY smb.conf /etc/samba/smb.conf
COPY avahia.service /etc/avahi/services/timemachine.service
COPY supervisord.conf /etc/supervisord.conf
#RUN /tmp/setup.sh

VOLUME ["/timemachine"]
ENTRYPOINT ["/tmp/setup.sh"]
HEALTHCHECK --interval=5m --timeout=3s \
  CMD (avahi-daemon -c && \
        smbclient -L '\\localhost' -U '%' -m SMB3 &>/dev/null) || exit 1
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
