# Comandos comunes de administración
## `SHOW STATUS;`
Muestra información sobre el estado del servidor MySQL/MariaDB, incluyendo métricas como conexiones activas, consultas ejecutadas y carga del sistema.
Útil para monitoreo y diagnóstico de rendimiento.

## `SHOW PROCESSLIST;`
Lista los procesos en ejecución en el servidor de base de datos, mostrando detalles como ID de conexión, usuario, consulta en ejecución y estado.
Ayuda a identificar consultas lentas o bloqueadas.

## `USE <database>;`
Cambia el contexto a una base de datos específica, permitiendo ejecutar consultas dentro de ella sin necesidad de especificar su nombre en cada instrucción.
```sql
USE sakila;
```

## `SHOW TABLES`
Muestra todas las tablas dentro de la base de datos actualmente seleccionada.
Se debe usar después de seleccionar una base de datos con USE \<database\>;.

## `SHOW DATABASES;`
Lista todas las bases de datos disponibles en el servidor
Útil para verificar qué bases de datos existen antes de conectarse a una específica.
