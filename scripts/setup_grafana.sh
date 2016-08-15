#!/bin/bash -e

if [[ ! -z  ${GRAFANA_USER} ]]; then
  echo "####### SETUP Grafana User Name to: $GRAFANA_USER"
  sed -i "s/;admin_user = admin/admin_user = ${GRAFANA_USER}/g" /etc/grafana/grafana.ini
fi

if [[ ! -z  ${GRAFANA_PASS} ]]; then
  echo "####### SETUP Grafana User Password to: $GRAFANA_PASS"
  sed -i "s/;admin_password = admin/admin_password = ${GRAFANA_PASS}/g" /etc/grafana/grafana.ini
fi
