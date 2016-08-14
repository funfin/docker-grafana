{
    "name":"influx",
    "type":"influxdb",
    "url":"{{ INFLUXDB_PROTO | default("http") }}://{{ INFLUXDB_HOST | default("localhost") }}:{{ INFLUXDB_PORT | default("8086") }}",
    "access":"{{ INFLUXDB_ACCESS | default("direct") }}",
    "isDefault":false,
    "database":"{{ INFLUXDB_GRAFANA_DB | default("grafana") }}",
    "user":"{{ INFLUXDB_USER | default("root") }}",
    "password":"{{ INFLUXDB_PASS | default("toor") }}"
}
