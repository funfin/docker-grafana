# Grafana Docker image

This project builds a Docker image with the latest master build of Grafana(3.1.X).

## Build image

```
docker build -t grafana .
```

## Running your Grafana container

Start your container binding the external port `3000`.

```
docker run -d --name=grafana -p 3000:3000 oisis/grafana
```

Try it out, default admin user is admin/admin.

## Configuring your Grafana container

All options defined in conf/grafana.ini can be overriden using environment
variables, for example:

```
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  -e "GF_SERVER_ROOT_URL=http://grafana.server.name" \
  -e "GF_SECURITY_ADMIN_PASSWORD=secret" \
  oisis/grafana
```

## Grafana container with persistent storage (recommended)

```
# create /var/lib/grafana as persistent volume storage
docker run -d -v /var/lib/grafana --name grafana-storage busybox:latest

# start grafana
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  --volumes-from grafana-storage \
  oisis/grafana
```

## Installing plugins for Grafana 3

Pass the plugins you want installed to docker with the `GF_INSTALL_PLUGINS` environment variable as a comma seperated list. This will pass each plugin name to `grafana-cli plugins install ${plugin}`.

```
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  -e "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource" \
  oisis/grafana
```

## Running specific version of Grafana

```
# specify right tag, e.g. 2.6.0 - see Docker Hub for available tags
docker run \
  -d \
  -p 3000:3000 \
  --name grafana \
  oisis/grafana:2.6.0
```

## Configuring AWS credentials for CloudWatch support

```
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  -e "GF_AWS_PROFILES=default" \
  -e "GF_AWS_default_ACCESS_KEY_ID=YOUR_ACCESS_KEY" \
  -e "GF_AWS_default_SECRET_ACCESS_KEY=YOUR_SECRET_KEY" \
  -e "GF_AWS_default_REGION=us-east-1" \
  oisis/grafana
```

You may also specify multiple profiles to `GF_AWS_PROFILES` (e.g.
`GF_AWS_PROFILES=default another`).

## Setup InfluxDB data source:

```
docker run -d -p 3000:3000 -e GRAFANA_DATASOURCES="influxdb" \
  -e INFLUXDB_HOST=influxdb -e INFLUXDB_USER=root -e INFLUXDB_PASS=toor \
  -e INFLUXDB_ACCESS=direct -e INFLUXDB_GRAFANA_DB=collectd oisis/grafana
```

## Supported variables:

- `GRAFANA_BIN`: Grafana binary file location
- `GRAFANA_DATASOURCES`: Grafana data sources to add(default none), supported: elasticsearch, graphite, influsdb, opentsdb
- `ELASTIC_PROTO`: Elasticsearch host protocol(default http)
- `ELASTIC_HOST`: Elasticsearch host address(default localhost)
- `ELASTIC_PORT`: Elasticsearch host port (default 9200)
- `ELASTIC_ACCESS`: Elasticsearch access mode(default proxy)
- `GRAPHITEDB_PROTO`: Graphite host protocol(default http)
- `GRAPHITEDB_HOST`: Graphite host address(default localhost)
- `GRAPHITEDB_PORT`: Graphite host port (default 8080)
- `GRAPHITEDB_ACCESS`: Graphite access mode(default direct)
- `INFLUXDB_PROTO`: InfluxDB host protocol(default http)
- `INFLUXDB_HOST`: InfluxDB host address(default localhost)
- `INFLUXDB_PORT`: InfluxDB host port (default 8086)
- `INFLUXDB_ACCESS`: InfluxDB access mode(default direct)
- `INFLUXDB_GRAFANA_DB`: InfluxDB DB for Grafana(default grafana)
- `INFLUXDB_USER`: InfluxDB username(default root)
- `INFLUXDB_PASS`: InfluxDB password(default toor)
- `OPENTSDB_PROTO`: OpenTSDB host protocol(default http)
- `OPENTSDB_HOST`: OpenTSDB host address(default localhost)
- `OPENTSDB_PORT`: OpenTSDB host port (default 4242)
- `OPENTSDB_ACCESS`: OpenTSDB access mode(default proxy)
- `OPENTSDB_VERSION`: OpenTSDB server version(default 2.2 - not working yet)
- `OPENTSDB_RESOLUTION`:  OpenTSDB resolution)default second - not working yet)
- `GF_AWS_PROFILES`: AWS profile name
- `GF_AWS_${profile}_ACCESS_KEY_ID`: AWS access key ID (required).
- `GF_AWS_${profile}_SECRET_ACCESS_KEY`: AWS secret access  key (required).
- `GF_AWS_${profile}_REGION`: AWS region (optional).
