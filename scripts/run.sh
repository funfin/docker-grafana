#!/bin/bash -e

#GRAFANA_USER="admin"
#GRAFANA_PASS="admin"
API_URL="http://localhost:3000"

: "${GF_PATHS_DATA:=/var/lib/grafana}"
: "${GF_PATHS_LOGS:=/var/log/grafana}"
: "${GF_PATHS_PLUGINS:=/var/lib/grafana/plugins}"

chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_LOGS"
chown -R grafana:grafana /etc/grafana

/aws.sh
/plugins.sh

wait_for_start_of_grafana(){
  #wait for the startup of grafana
  local retry=0
  while ! curl ${API_URL} 2>/dev/null; do
    retry=$((retry+1))
    if [ $retry -gt 30 ]; then
      echo "\nERROR: unable to start grafana"
      exit 1
    fi
    echo -n "."
    sleep 1
  done
  /configure.sh
  echo
}
wait_for_start_of_grafana &

exec gosu grafana /usr/sbin/grafana-server  \
  --homepath=/usr/share/grafana             \
  --config=/etc/grafana/grafana.ini         \
  cfg:default.paths.data="$GF_PATHS_DATA"   \
  cfg:default.paths.logs="$GF_PATHS_LOGS"   \
  cfg:default.paths.plugins="$GF_PATHS_PLUGINS" web
