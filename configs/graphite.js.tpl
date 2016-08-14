{
    "name":"graphite",
    "type":"graphite",
    "url":"{{ GRAPHITEDB_PROTO | default("http") }}://{{ GRAPHITEDB_HOST | default("localhost") }}:{{ GRAPHITEDB_PORT | default("8080") }}",
    "access":"{{ GRAPHITEDB_ACCESS | default("direct") }}",
    "isDefault":false,
}
