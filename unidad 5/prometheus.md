# Prometheus
Prometheus es una herramienta de monitorización y alerta de código abierto diseñada para recopilar métricas de sistemas, servicios y aplicaciones. Es especialmente popular en entornos de infraestructura moderna como contenedores, microservicios y entornos cloud.

## Exportadores

### node_exporter
[`node_exporter`](https://github.com/prometheus/node_exporter) es un componente clave en el ecosistema de Prometheus, diseñado para recopilar métricas del sistema operativo y del hardware del servidor. Su función principal es exponer esta información en un endpoint HTTP para que Prometheus la recolecte.
#### Métricas de interes
- Uso de CPU.
- Memoria RAM.
- Espacio en disco.
- Red.
- Estado del hardware: Temperatura, voltaje y ventiladores (en hardware compatible).
- Información del sistema operativo: Procesos activos, uptime, etc.

### mysqld_exporter
[`mysqld_exporter`](https://github.com/prometheus/mysqld_exporter) es una herramienta desarrollada por la comunidad de Prometheus que permite extraer métricas detalladas sobre el estado y rendimiento de bases de datos MySQL o MariaDB. Su función principal es exponer esta información en un endpoint HTTP para que Prometheus la recopile.
#### Métricas de interes
- Estado de las conexiones activas.
- Número de consultas por segundo.
- Uso de memoria del servidor MySQL.
- Información sobre bloqueos y transacciones.
- Estado de los índices y tablas.
- Detalles del replication status (en configuraciones maestro-esclavo).

## Finalidad de las practicas
Instalar prometheus para monitorizar el servidor de base de datos que ya realizaron. Esto con la finalidad de ver la correcta operatividad del servidor y del servicio de base de datos, o en su defecto ver en donde falla el servicio o servidor en caso de un problema para agilizar el diagnostico de problemas.

## Arquitectura
Prometheus es un [_scraper_](https://en.wikipedia.org/wiki/Web_scraping). Se le indica al recolector de estadisticas donde se encuentran estas, y Prometheus recolecta y almacena los datos para posterior analisis. Esto se realiza mediante exportadores, los cuales son [_hooks_](https://en.wikipedia.org/wiki/Hooking) que traducen los datos a un formato que Prometheus pueda entender.

### Diagrama de la documentacion
![Arquitectura de Prometheus](https://prometheus.io/assets/architecture.png)

### Diagrama simplificado
![image](https://github.com/user-attachments/assets/0c896b26-8497-494e-a07e-a6009fa0dc66)

## Supuestos de este documento
- Ya se tiene un servidor de base de datos andando.
- Se tiene el servidor nombrado mediante el archivo hosts. Se asume que se llama `database`.
- Los archivos se descargaran y descomprimiran en su directorio home. Su directorio home es aquel que pueden acceder mediante: `~`.

## Pasos de instalacion
### Descarga
Los paquetes de prometheus no se encuentran en repositorios oficiales de sistemas operativos, por lo cual hay que descargarlos y configurarlos manualmente. Los enlaces de los paquetes estan disponibles en:
- Prometheus: https://prometheus.io/download/
- node_exporter: https://github.com/prometheus/node_exporter/releases
- mysqld_exporter: https://github.com/prometheus/mysqld_exporter/releases

Las descargas en linea de comando se realizan con wget:
```
wget <url>
```
Para que quede explicitamente claro: Los anteriores enlaces NO SON LOS DE DESCARGA, son donde pueden encontrar los enlaces de descarga. Deben de escoger de manera correcta su sistema operativo y arquitectura de sistema.

### Instalacion
La instalacion es muy sencilla, simplemente debemos descomprimir los archivos descargados con el comando `tar -xvzf <nombre del archivo>` y se nos descomprimiran en directorios.

Estos directorios tendran nombres largos, los cuales nos convendra acortar, con el comando `mv <origen> <destino>` renombramos los directorios, para que queden simplemente nombrados: `prometheus`, `node_exporter` y `mysqld_exporter`

Por ejemplo:
```
mv prometheus-bla-bla-y-mas-bla prometheus
```

__A partir de aqui, se asume que los directorios se llaman como se describio anteriormente.__

### Ejecución
Para verificar que la descarga y descompresion de los archivos es correcta, hay que ejecutar los programas.

### Prometheus
Vamos al directorio donde esta prometheus:
```bash
cd ~/prometheus
```

Y ejecutamos, notese que hay que indicar al programa donde se encuentra el archivo de configuracion con el argumento `--config.file`. Prometheus contiene un archivo de configuracion por defecto.
```bash
./prometheus --config.file=prometheus.yml
```

Si al ejecutar el programa, y leer la salida, podemos ver lo siguiente, significara que esta corriendo correctamente:
> "Listening on" component=web address=[::]:9090
> "Server is ready to receive web requests."

Podremos comprobar que el servidor esta ejecutandose entrando a nuestro servidor. Se puede acceder a: http://database:9090 y ver la siguiente pantalla:

![image](https://github.com/user-attachments/assets/aff1de19-6e8d-4823-852a-8651a8d4b22e)

### `mysqld_exporter`
`mysqld_exporter` necesita un usuario para poder acceder a nuestro servidor de base de datos. La documentacion de ellos nos provee con el comando CREATE USER adecuado, en nuestro servidor de base de datos damos los comandos:
```sql
CREATE USER 'exporter'@'localhost' IDENTIFIED BY 'CAMBIAR_ESTE_PASSWORD' WITH MAX_USER_CONNECTIONS 3;
```

Y damos permisos al usuario creado:
```sql
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'localhost';
```

Vamos al directorio donde esta mysqld_exporter:
```bash
cd ~/mysqld_exporter
```

Antes de iniciar el exportador, debemos crear un archivo donde especificamos con que usuario y contraseña el exportador accedera al servidor de base de datos.
Creamos un archivo llamado `config.my.cnf`.
```bash
nano config.my.cnf
```

Teniendo en cuenta lo anterior, el contenido del archivo debera ser el siguiente:
```
[client]
user = exporter
password = CAMBIAR_ESTE_PASSWORD
```
Ejecutamos el programa, a este hay que darle el archivo de configuracion mediante el argumento `--config.my-cnf`.
```bash
./prometheus --config.my-cnf=config.my.cnf
```

Si vemos lo siguiente en la salida del programa, este se estara ejecutando con exito:
> "Listening on" address=[::]:9104


Asi mismo, podemos comprobar en http://database:9104 que el programa se ejecuta de manera correcta.

![image](https://github.com/user-attachments/assets/4bf147d2-cb9f-4293-b944-4c6a2d2fd927)

### `node_exporter`
Este es el servicio mas sencillo de poner en marcha, simplemente vamos al directorio
```bash
cd ~/node_exporter
```

Y ejecutamos.
```bash
./node_exporter
```

Si vemos lo siguiente en la salida del programa, este se estara ejecutando con exito:

> "Listening on" address=[::]:9100

Asi mismo, podemos comprobar en http://database:9100 que el programa se ejecuta de manera correcta.

![image](https://github.com/user-attachments/assets/f42f73a0-8021-4a47-8077-0138caf798fe)

## Archivo de configuracion de prometheus.
Si nos vamos a la carpeta donde tenemos Prometheus:

```bash
cd ~/prometheus
```
El archivo es `prometheus.yml`

La configuracion final de este archivo quedaria de esta manera:
```yml
# Configuracion global de prometheus
global:
  scrape_interval: 15s # Asigna el intervalo de recoleccion a 15 segundos. Por defecto es de un minuto.
  evaluation_interval: 15s # Se evaluan las reglas, o los cambios en estas cada 15 segundos. Por defecto es de un minuto.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# La configuracion de donde se realizara la recoleccion de datos.
scrape_configs:
  # El job name es agregado como etiqueta a cualquier serie de tiempo que se saque despues.
  # Prometheus es capaz de sacar estadisticas de si mismo.
  - job_name: "prometheus"
    # metrics_path (ruta de metricas) por defecto es: '/metrics'
    # por defecto es http, no https.
    static_configs:
      - targets: ["localhost:9090"]

  # Este es el trabajo donde definimos que queremos sacar estadisticas de node_exporter.
  # El objetivo (target) del cual queremos recolectar estadisticas esta en localhost, relativamente
  # a donde estamos ejecutando prometheus server.

  # Este nos dara estadisticas de nuestra computadora.
  - job_name: node
    static_configs:
      - targets: ['localhost:9100']


  # Configuración del trabajo para monitorear MariaDB utilizando el mysqld_exporter.
  # Esta configuración permite que Prometheus recopile métricas del servicio MariaDB
  # a través del exporter, el cual escucha en el puerto 9104.
  - job_name: "MariaDB"
    params:
    static_configs:
      - targets:
        - localhost:3306
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: localhost:9104
```
