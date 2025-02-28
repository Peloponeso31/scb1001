# Modificar archivo `hosts`

Dependiendo de si estamos trabajando bajo Windows o Linux, los archivos se encuentran en:
- Windows: `C:\Windows\System32\Drivers\etc\hosts`.
- Linux: `/etc/hosts`.

Abrimos el archivo de texto segun nuestra plataforma
- Windows: abrir el block de notas __como administrador__ y abrir/crear el archivo en la ruta especificada.
- Linux: `sudo nano /etc/hosts`.

Para agregar un hosts, se sigue la siguiente sintaxis:
```
[Direccion IP] [Nombre]
```

Por ejemplo, si queremos crear un nombre para uno de nuestros huespedes de VirtualBox, asumiendo que este tiene la direccion IP `192.168.56.101`, tenemos que agregar lo siguiente al final de nuestro archivo hosts:
```
192.168.56.101 database
```

En caso de Windows, al guardar los cambios en nuestro archivo, tenemos que darl el siguiente comando en PowerShell/CMD:
```ps
ipconfig /flushdns
```

Para comprobar que funciona, damos un ping al nombre del host:
```ps
ping database
```

Devolviendo una salida parecida a esta:
```
pinging database [192.168.56.101] with 32 bytes of data:
    Reply from 192.168.56.101: bytes=32 time=101ms TTL=124
    Reply from 192.168.56.101: bytes=32 time=100ms TTL=124
    Reply from 192.168.56.101: bytes=32 time=120ms TTL=124
    Reply from 192.168.56.101: bytes=32 time=120ms TTL=124
```
