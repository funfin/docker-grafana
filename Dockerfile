FROM debian:jessie

MAINTAINER OiSiS (https://github.com/oisis)

RUN apt-get update && apt-get -y install apt-transport-https curl python-pip

RUN echo "deb https://packagecloud.io/grafana/stable/debian/ wheezy main" >> /etc/apt/sources.list && \
    curl https://packagecloud.io/gpg.key | apt-key add - && \
    apt-get update && \
    apt-cache show grafana && \
    apt-get -y --no-install-recommends install grafana

RUN pip install envtpl

RUN curl -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/sbin/gosu && \
    chmod +x /usr/sbin/gosu && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Configure Grafana
RUN mkdir -p /etc/grafana/datasources
COPY configs/ /etc/grafana/datasources/
COPY scripts/ /

RUN chmod +x /*.sh

ENV GRAFANA_BIN /bin/grafana-server
ENV GRAFANA_USER admin
ENV GRAFANA_PASS admin

VOLUME ["/var/lib/grafana", "/var/lib/grafana/plugins", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
