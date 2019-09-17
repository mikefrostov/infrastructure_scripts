FROM        quay.io/prometheus/busybox:latest
MAINTAINER  The Prometheus Authors <prometheus-developers@googlegroups.com>

COPY prometheus                             /bin/prometheus
COPY promtool                               /bin/promtool
COPY prometheus.yml                         /etc/prometheus/prometheus.yml
COPY console_libraries/                     /etc/prometheus/
COPY consoles/                              /etc/prometheus/

RUN ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles/ /etc/prometheus/
RUN mkdir -p /prometheus && \
    chown -R nobody:nogroup etc/prometheus /prometheus


EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.console.libraries=/etc/prometheus/console_libraries", \
             "--web.console.templates=/etc/prometheus/consoles" ]
