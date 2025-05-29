# Configuracion de proxy.

⚠️⚠️ __UNDER CONSTRUCTION__ ⚠️⚠️

## Agregar el repositorio de MariaDB.
Si se esta usando Ubuntu 24.04 LTS, pueden usar el comando dado por MariaDB:
```sh
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash
```

De lo contrario, se debera forzar la version:
```sh
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash -s -- --os-type=ubuntu --os-version=noble
```

Ahora, MaxScale podra ser instalable:
```sh
sudo apt install maxscale
```

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

Todos estos certificados deben ser visibles por grupo y todos (655).
```sh
sudo chmod 655 -R /etc/maxscale.cnf.d/tls
```

## Archivo de configuracioón de ejemplo, cambiar a conveniencia.
Abran el archivo `/etc/maxscale.cnf` para que se vea como lo siguiente:
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
port=3306
ssl=true
ssl_ca=/ruta/al/server//ca.crt
ssl_key=/ruta/al/server/proxy.key
ssl_cert=/ruta/al/server/proxy.crt
```
