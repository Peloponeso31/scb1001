# Configurar grafana para enviar alertas via correo electronico.
Para probar nuestras alertas via correo utilizaremos mailpit. 

## Supuestos de esta guia:
- Se tiene grafana corriendo, y todo lo que implica llegar a correrlo (prometheus y exportadores).
- Se tiene un servidor de base de datos.
- El nombre del host es `database`

## Mailpit
Mailpit es una herramienta ligera para capturar, visualizar y depurar correos electrónicos en entornos de desarrollo. Actúa como un servidor SMTP local que intercepta los correos enviados desde tu aplicación, permitiéndote ver su contenido en una interfaz web intuitiva. Es ideal para probar el envío de emails sin necesidad de que estos lleguen realmente a los destinatarios.

### Instalación
Simplemente damos el comando:
```bash
sudo bash < <(curl -sL https://raw.githubusercontent.com/axllent/mailpit/develop/install.sh)
```

Podemos ver donde esta el ejecutable de mailpit con el comando:
```bash
whereis mailpit
```

Al terminar de instalarse, crearemos un archivo de unidad de systemd:
```bash
sudo nano /etc/systemd/system/mailpit.service
```

Al terminarlo, ctivamos e iniciamos el servicio:
```bash
sudo systemctl enable --now mailpit.service
```

Si vamos a http://database:8025/ deberemos poder ver la interfaz web de mailpit.

![image](https://github.com/user-attachments/assets/042d57ab-409b-4164-ad1d-035c2a4bf94b)

## Configuracion de grafana
Para poder enviar correos electronicos de alertas mediante grafana, deberemos de abrir el archivo grafana.ini, es un archivo bastante largo, por lo que le daremos el argumento `+n` para abrirlo en la linea 1034.
```bash
sudo nano +1034 /etc/grafana/grafana.ini
```

El archivo se abrira en la seccion `[smtp]`.

Refiriendonos a la documentacion de mailpit, esta nos dice que el servidor smtp corre en el puerto 1025, por lo cual deberemos editar el archivo para que quede de la siguiente manera:
```
[smtp]
enabled = true
host = localhost:1025
```
Guardamos, y reiniciamos el servicio de grafana-server.service.
```bash
sudo systemctl restart grafana-server.service
```

