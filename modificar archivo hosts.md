# Modificar archivo hosts

Dependiendo de si estamos trabajando bajo Windows o Linux, los archivos se encuentran en:
- Windows: `C:\Windows\System32\Drivers\etc\hosts`.
- Linux: `/etc/hosts`.

Abrimos el archivo de texto segun nuestra plataforma
- Windows: abrir el block de notas como administrador y abrir/crear el archivo en la ruta especificada.
- Linux: `sudo nano /etc/hosts`.

Para agregar un hosts, se sigue la siguiente sintaxis:
```
[Direccion IP] [Nombre]
```

Por ejemplo, si queremos crear un nombre para uno de nuestros guespedes de VirtualBox, asumiendo que este tiene la direccion IP `192.168.56.101`, tenemos que agregar lo siguiente al final de nuestro archivo hosts:
```
192.168.56.101 database
```
