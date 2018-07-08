FROM alpine:3.7

COPY ./bin/dnsdata_update.sh /
COPY ./bin/run_axfrdns.sh /
COPY ./bin/tinydns-data /usr/local/bin
COPY ./bin/envdir /usr/local/bin
COPY ./bin/envuidgid /usr/local/bin
COPY ./bin/softlimit /usr/local/bin
COPY ./bin/tcpserver /usr/local/bin
COPY ./bin/tcprules /usr/local/bin
COPY ./bin/tai64n /usr/local/bin
COPY ./bin/tai64nlocal /usr/local/bin
COPY ./bin/axfrdns /usr/local/bin
COPY ./bin/axfrdns-conf /usr/local/bin

RUN apk add --no-cache git make bind-tools openssh grep && \
    mkdir /root/.ssh && \
    adduser -S axfrdns && \
    axfrdns-conf axfrdns axfrdns /etc/axfrdns /etc/axfrdns/root 0.0.0.0 && \
    mkdir -p /etc/axfrdns/env && \
    mkdir /etc/axfrdns/root && \
    echo "/etc/axfrdns/root" > /etc/axfrdns/env/ROOT && \
    echo "0.0.0.0" > /etc/axfrdns/env/IP && \
    echo "axfrdns" > /etc/axfrdns/env/UID && \
    echo "axfrdns" > /etc/axfrdns/env/GID && \
    ln -sf /usr/local/bin/tinydns-data /usr/bin/tinydns-data && \
    ln -sf /usr/local/bin/axfrdns-conf /usr/bin/axfrdns-conf && \
    ln -sf /usr/local/bin/axfrdns /usr/bin/axfrdns && \
    ln -sf /etc/axfrdns/root/tcp.cdb /etc/axfrdns/tcp.cdb

EXPOSE 53/tcp

CMD ["/run_axfrdns.sh"]

