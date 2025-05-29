# Configuracion de servidores.

⚠️⚠️ __UNDER CONSTRUCTION__ ⚠️⚠️

## Permisos usuario y `GRANT`s del Splitter Service.
```sql
CREATE USER 'maxscale'@'%' IDENTIFIED BY 'maxscale_pw';
GRANT SELECT ON mysql.user TO 'maxscale'@'%';
GRANT SELECT ON mysql.db TO 'maxscale'@'%';
GRANT SELECT ON mysql.tables_priv TO 'maxscale'@'%';
GRANT SELECT ON mysql.columns_priv TO 'maxscale'@'%';
GRANT SELECT ON mysql.procs_priv TO 'maxscale'@'%';
GRANT SELECT ON mysql.proxies_priv TO 'maxscale'@'%';
GRANT SELECT ON mysql.roles_mapping TO 'maxscale'@'%';
GRANT SHOW DATABASES ON *.* TO 'maxscale'@'%';
```

## Usuario y grants del Replication Monitor.
```sql
CREATE USER 'replication'@'%' IDENTIFIED BY 'PASSWORD';
GRANT REPLICATION MASTER ADMIN, REPLICATION SLAVE ADMIN, 
REPLICATION SLAVE, SLAVE MONITOR ON *.* TO 'replication'@'%';
```

Siempre, al realizar GRANTS, se debe de correr:
```sql
FLUSH PRIVILEGES;
```
