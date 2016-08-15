{
    "name": "opentsdb",
    "type": "opentsdb",
    "access": "{{ OPENTSDB_ACCESS | default("proxy") }}",
    "url": "{{ OPENTSDB_PROTO | default("http") }}://{{ OPENTSDB_HOST | default("localhost") }}:{{ OPENTSDB_PORT | default("4242") }}",
    "basicAuth": false,
    "basicAuthUser": "",
    "basicAuthPassword": "",
    "withCredentials": false,
    "isDefault": false,
    "jsonData": {
        "tsdbResolution": {{ OPENTSDB_VERSION | default("2") }},
        "tsdbVersion": {{ OPENTSDB_VERSION | default("2") }}
    }
}
