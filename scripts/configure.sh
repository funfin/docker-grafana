#!/bin/bash -e

GRAFANA_USER="admin"
GRAFANA_PASS="admin"

if [ ! -z ${GRAFANA_DATASOURCES} ]; then
  IFS=','
  for datasource in ${GRAFANA_DATASOURCES}; do
    echo "Deploying configuration for data source: $datasource"
    envtpl /etc/grafana/datasources/${datasource}.js.tpl
    curl "http://${GRAFANA_USER}:${GRAFANA_PASS}@127.0.0.1:3000/api/datasources" -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary @/etc/grafana/datasources/${datasource}.js
  done
fi

echo DONE > /var/lib/grafana/.grafana_datasources
