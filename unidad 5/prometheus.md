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
cd prometheus
```

Y ejecutamos, notese que hay que indicar al programa donde se encuentra el archivo de configuracion con el argumento `--config.file`. Prometheus contiene un archivo de configuracion por defecto.
```bash
./prometheus --config.file=prometheus.yml
```

Si al ejecutar el programa, y leer la salida, podemos ver lo siguiente, significara que esta corriendo correctamente:
```
"Listening on" component=web address=[::]:9090
"Server is ready to receive web requests."
```
