# Configurar SSL y TLS en MariaDB

## Pasos:
### Instalar `easy-rsa`
Se instala Easy RSA, este nos servira para hacer el _certificate authority_ asi como la firma de certificados, tanto de servidor como de clientes.

```sh
sudo apt install easy-rsa
```

### Configuración del directorio de trabajo
Trabajaremos en el directorio home (`~`), crearemos una carpeta llamada `easy-rsa` donde estaran todos los archivos con los que estaremos trabajando.
```sh
mkdir ~/easy-rsa
```

Copiamos los contenidos de `/usr/share/easy-rsa` en la carpeta que acabamos de crear.
```sh
cp -r /usr/share/easy-rsa/* ~/easy-rsa/
```

Nos metemos en el directorio creado.
```sh
cd ~/easy-rsa
```

El directorio debe tener los siguientes contenidos
```
total 168
-rwxr-xr-x 1 tanil tanil 144336 Apr  7 19:19 easyrsa
-rw-r--r-- 1 tanil tanil   5145 Apr  7 19:19 openssl-easyrsa.cnf
-rw-r--r-- 1 tanil tanil   9085 Apr  7 19:19 vars.example
drwxr-xr-x 2 tanil tanil   4096 Apr  7 19:19 x509-types
```
El contenido consiste en una configuracion minima de openssl, el ejecutable y una base de datos de llaves (`x509-types`).

Confirmando el contenido del directorio, damos el comando
```sh
./easyrsa init-pki
```

### Gestión de llaves
Construimos el _certificate authority_ o como comunmente se abrevia: CA. Este les pedira poner una contraseña.
```sh
./easyrsa build-ca
```

Ya teniendo el CA, podemos generar la llave de servidor.
```sh
./easyrsa gen-req database nopass
```

Posteriormente lo firmamos con el CA.
```sh
./easyrsa sign-req server database
```

Deberemos tener los siguientes archivos al terminar esto:
```
easy-rsa/
└── pki/
    ├── ca.crt
    ├── issued/
    │   └── database.crt
    └── private/
        ├── ca.key
        └── database.key
```

### Generacion y firma de certificados para clientes
Esos les permitiran a nuestro cliente conectarse a nuestro servidor de base de datos cifrando tanto la entrada como la salida.

Damos el comando
```sh
./easyrsa gen-req cliente nopass
```

```sh
./easyrsa sign-req client cliente
```

### Configuracion de mariadb
Creamos un directorio donde colocar los certificados en el servidor de base de datos.
```sh
sudo mkdir -p /etc/mysql/ssl
```

Copiamos los certificados a este directorio.
```sh
sudo cp pki/ca.crt /etc/mysql/ssl/
sudo cp pki/issued/database.crt /etc/mysql/ssl/
sudo cp pki/private/database.key /etc/mysql/ssl/
```

Cambiamos al dueño de estos archivos a `mariadb` y grupo `mariadb`
```sh
sudo chown -R mysql:mysql /etc/mysql/ssl
```

Ponemos los permisos al archivo `database.key` de tal modo que solo el dueño puede leer y escribir.
```sh
sudo chmod 600 /etc/mysql/ssl/database.key
```

Abrimos el archivo `/etc/mysql/mariadb.conf.d/50-server.cnf` y vamos a la seccion `SSL/TLS`, esta seccion nos tiene que quedar de la siguiente manera:
```
ssl-ca = /etc/mysql/ssl/ca.crt
ssl-cert = /etc/mysql/ssl/database.crt
ssl-key = /etc/mysql/ssl/database.key
require-secure-transport = on
```

Para finalizar, reiniciamos el servicio de `mariadb`
```sh
sudo systemctl restart mariadb.service
```

### Comprobación
Nos metemos a nuestro servidor de MariaDB y vemos las rutas correspondientes de los certificados, nuestro SSL estara configurado de manera correcta.
```sql
SHOW VARIABLES LIKE '%ssl%';
```

Si lo siguiente muestra un valor, tambien significa que nuestro SSL esta configurado de manera correcta.
```sql
SHOW STATUS LIKE 'Ssl_cipher';
```
