# Creacion de usuario administrativo remoto

Para crear el usuario `admin` con el password `password` y que ademas cuente con acceso remoto y permisos administrativos, se debe dar el siguiente comando dentro de MariaDB:
```mysql
GRANT ALL ON *.* TO 'admin'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
```

Despues de crearlo, se deben refrescar los privilegios.
```mysql
FLUSH PRIVILEGES;
```

Una vez refresacados, el acceso remoto con el usuario `admin` es posible.
