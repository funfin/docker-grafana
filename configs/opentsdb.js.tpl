{
    "name":"opentsdb",
    "type":"opentsdb",
    "url":"{{ OPENTSDB_PROTO | default("http") }}://{{ OPENTSDB_HOST | default("localhost") }}:{{ OPENTSDB_PORT | default("4242") }}",
    "access":"{{ OPENTSDB_ACCESS | default("direct") }}",
    "isDefault":false,
    "version":"{{ OPENTSDB_VERSION | default("2.2") }}",
    "resolution":"{{ OPENTSDB_RESOLUTION | default("second") }}"
}
