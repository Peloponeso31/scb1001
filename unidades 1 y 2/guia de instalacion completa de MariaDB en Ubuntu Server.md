# Guia de instalacion completa para instalar MariaDB en Ubuntu Server

## Pasos especificos para este curso
Teniendo en cuenta que utilizaremos una maquina virtual a modo de servidor de base de datos, necesitamos configurar previamente esta para satisfacer nuestras necesidades.

### Crear una nueva máquina virtual
- Abre VirtualBox y haz clic en "Nueva".
- Asigna un nombre (ej. database, ya que sera nuestro servidor de BD).
- Elige el tipo como Linux y la versión como Ubuntu (64-bit).
- Haz clic en "Siguiente".

### Configurar la memoria RAM
- Asigna al menos 1024 MB (1 GB) de RAM (recomendado 2 GB o más).
- Haz clic en "Siguiente".

### Crear un disco duro virtual
- Selecciona "Crear un disco duro virtual ahora" y haz clic en "Crear".
- Elige el tipo de disco VDI (VirtualBox Disk Image).
- Selecciona "Reservado dinámicamente" para ahorrar espacio.
- Asigna al menos 10 GB de almacenamiento, se recomiendan 20..
- Haz clic en "Crear".

### Configurar la máquina virtual
- Selecciona la VM y haz clic en "Configuración".
- En "Procesador", asigna al menos 2 núcleos si es posible, se pueden seleccionar todos los disponibles sin efectos adversos.

### Agregar las interfaces de red
En este curso, necesitamos configurar dos interfaces de red. Una permitirá que nuestra máquina virtual se conecte a Internet, mientras que la otra será utilizada para la comunicación interna con el host. Esta segunda interfaz nos permitirá acceder a diversos servicios, como la base de datos o la conexión a la máquina mediante SSH.

- Ve a la pestaña "Red":
    - Adaptador 1: De no encontrarse activada, activa la casilla "Habilitar adaptador de red" y selecciona "NAT". Esta es usualmente la interfaz por defecto.
    - Adaptador 2: Activa la casilla "Habilitar adaptador de red", elige "Solo anfitrión" y selecciona la red correspondiente (por defecto suele ser vboxnet0).

### Cargar la imagen ISO de Ubuntu Server
- Ve a la pestaña "Almacenamiento".
- En "Controlador: IDE", selecciona "Vacío" y haz clic en el icono de disco.
- Elige "Seleccionar un archivo de disco" y carga la ISO de Ubuntu Server.
### Iniciar la instalación
- Haz clic en "Iniciar" para arrancar la VM.
- Sigue las instrucciones del instalador de Ubuntu Server.
- Configura la red y las opciones según tu preferencia.

## Pasos generales para la instalacion del servidor
Asumiendo que recibimos una computadora nueva y sellada que vamos a utilizar como servidor.

### Iniciar la instalacion del sistema operativo.
Arranca la máquina con la ISO de Ubuntu Server y sigue el asistente de instalación.

Esta instalacion es muy sencilla, parecida incluso a la instalacion de un programa de windows, en la cual podemos dar siguiente en los pasos sin mayor preocupación.

### Marcar para instalacion el paquete de servidor SSH.
Durante la instalación, selecciona la opción para instalar el servidor SSH, este permitira el acceso remoto.

La pantalla en cuestión se ve asi:

![image](https://github.com/user-attachments/assets/22dc41f1-9ccd-44ea-8fb1-ff7236886f62)


### Definir hostname, nombre de usuario y contraseña del servidor.
Asigna un nombre al servidor y crea un usuario con su respectiva contraseña para la administración. Debes memorizar este usuario y contraseña que asignes.

La pantalla donde definen eso, se ve asi:

![image](https://github.com/user-attachments/assets/bd1379b2-3751-402c-9e00-026f2d363370)


### Iniciar el servidor con el sistema operativo instalado.
Una vez finalizada la instalación, reinicia la máquina y accede al sistema con las credenciales anteriormente creadas.

### Instalar paquete mariadb-server.
Usa el gestor de paquetes para instalar MariaDB, el sistema gestor de bases de datos.

```sh
sudo apt install mariadb-server
```

De saltar algun error o de no encontrarse el paquete, siempre es buena idea antes actualizar los repositorios.

```sh
sudo apt update
```

### Modificar archivo 50-server.cnf, en el atributo de bind-address para dar servicio en todas las interfaces.
Edita la configuración en `/etc/mysql/mariadb.conf.d/50-server.cnf` y cambia el valor de `bind-address` a `0.0.0.0` para permitir conexiones externas.

### Activar y/o reiniciar el servicio de mariadb.service.
Asegúrate de que el servicio de MariaDB esté en ejecución y se inicie automáticamente.

Usualmente, durante la instalacion este servicio se activa (enable) de manera automatica, pero siempre es buena idea comprobarlo de primera mano mediante el comando

```sh
systemctl status mariadb.service
```

El servicio tiene que estar activado (`enabled`) y ejecutandose (`running`) correctamente, podemos ver que este es el caso cuando en status esta en `Taking your SQL requests now...`

En caso de no estar activado, damos el comando:
```sh
sudo systemctl enable --now mariadb.service
```

En caso de ya estar ejecutandose, tomando en cuenta que el anterior paso fue cambiar el archivo de configuracion, necesitamos reiniciar el servicio para que los cambios surtan efecto, esto se logra con el comando:

```sh
sudo systemctl restart mariadb.service
```

### Crear un usuario administrativo en MariaDB.
Refierase a [crear usuario administrativo](https://github.com/Peloponeso31/scb1001/blob/main/unidades%201%20y%202/crear%20usuario%20administrativo.md). Este nos permitira el acceso remoto.

### Probar conexion desde otro host con un cliente de MariaDB, ya sea CLI o por medio de alguna aplicación.
Deben tener un cliente de mariadb instalado, de no tenerlo, refierase a la guia para instalar el cliente de linea de comandos.

De tener el cliente instalado, deben acceder remotamente:

```sh
mysql -h [HOST] -u [USUARIO] -p --skip-ssl
```

Es decir, si mi host es `database` y mi usuario es `tanil`, entonces mi comando se veria asi:

```sh
mysql -h database -u tanil -p --skip-ssl
```
