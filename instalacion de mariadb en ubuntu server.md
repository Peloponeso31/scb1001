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
