# Instalacion de MariaDB en Ubuntu Server

De no estar actualizados, actualizar repositorios.
```sh
sudo apt update
```

Se instala el _servidor de base de datos_.
```sh
sudo apt install mariadb-server
```

Se activa el servidor por medio de systemd.
```sh
sudo systemctl enable --now mariadb.service
```

Para verificar que este correctamente instalado, ver la salida del siguiente comando, debe estar _Active_ y _Running_.
```sh
systemctl status mariadb.service
```

Por ultimo, se debe modificar el archivo `/etc/mysql/mariadb.conf.d/50-server.cnf` en la linea referente a bind-address para poder publicitar el servicio.
```sh
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```

Este debe decir ```bind-address = 0.0.0.0```, esto habilita el servicio en red y accesible remotamente.
