# Configuracion de proxy.

⚠️⚠️ __UNDER CONSTRUCTION__ ⚠️⚠️

## Estructura de directorios recomendada para guardar los certificados SSL/TLS.
```
/etc/
└── /maxscale.cnf.d/
    └── tls/
        ├── client/
        │   ├── integrante 1/
        │   │   ├── ca.crt
        │   │   ├── cliente.crt
        │   │   └── cliente.key
        │   ├── integrante 2/
        │   │   ├── ca.crt
        │   │   ├── cliente.crt
        │   │   └── cliente.key
        │   ├── integrante 3/
        │   │   ├── ca.crt
        │   │   ├── cliente.crt
        │   │   └── cliente.key
        │   └── ...
        └── server/
            ├── ca.crt
            ├── proxy.crt
            └── proxy.key
```

## Archivo de configuracioón de ejemplo, cambiar a conveniencia.
```cnf
[maxscale]
threads=auto
admin_host=0.0.0.0
admin_secure_gui=false

[nombre_del_servidor]
type=server
address=xxx.xxx.xxx.xxx
port=3306
ssl=true
ssl_ca=/ruta/al/ca.crt
ssl_cert=/ruta/al/cliente.crt
ssl_key=/ruta/al/cliente.key
ssl_verify_peer_certificate=true

[Replication-Monitor]
type=monitor
module=mariadbmon
servers=nombre_del_servidor
user=replication
password=PASSWORD
monitor_interval=2000ms
auto_failover=true
auto_rejoin=true

[Splitter-Service]
type=service
router=readwritesplit
servers=nombre_del_servidor
user=maxscale
password=maxscale_pw

[Splitter-Listener]
type=listener
service=Splitter-Service
port=3310
ssl=true
ssl_ca=/ruta/al/server//ca.crt
ssl_key=/ruta/al/server/proxy.key
ssl_cert=/ruta/al/server/proxy.crt
```
