# Problemas de instalación vistos en clase.

## Errores de VirtualBox.
### VERR_SUP_VP_NT_QI_VIRTUAL_MEMORY_ERROR: (rc = -5637) [Por confirmar].
Este error, dados varios posts que he podido ver en distintos foros, se refiere a procesos interferiendo con virtualbox, pueden checar [este post](https://forums.virtualbox.org/viewtopic.php?t=110746) en los foros oficiales de VirtualBox recomendando desinstalar VBox y borrar los drivers que instala este.
Personalmente recomiendo añadir excepciones a sus antivirus de ser necesario asi como verificar que el _application sandboxing_ de Windows 11 este desactivado y/o verificar que VirtualBox este fuera de este.

## Errores de red.
### No hay dirección IP despues de haber instalado ubuntu server de manera satisfactoria.

#### Previa verificación:

##### Dentro de ubuntu server, la interfaz debe estar incluida en netplan.
Verificar que el archivo `/etc/netplan/50-cloud-init.yaml` contenga la interfaz en DHCP modo dhcp. Este se tiene que ver de esta manera, las interfaces `enp0s3` y `enp0s8` tienen que estar declaradas dentro de este. Los nombres pueden variar:
```yaml
network:
    ethernets:
        enp0s3:
            dhcp4: true
        enp0s8:
            dhcp4: true
            
    version: 2
```

El archivo puede ser abierto con el editor de texto de **linea de comando** de su preferencia, como por ejemplo nano.
```sh
sudo nano /etc/netplan/50-cloud-init.yaml
```

Los nombres de las interfaces (resaltadas en color azul) dentro de su propia instalacion de ubuntu server es:
```sh
ip --color auto
```
Las interfaces pueden significar:
- `lo`: Intefaz loopback. Esta es la interfaz que representa a 'localhost'.
- `enp0s3`: Interfaz que se presupone es la NAT. Los nombres de estas interfaces cambian. La direccion IP se ve parecida a `10.0.2.15` cuando es una direccion enmascarada por NAT.
- `enp0s8`: Interfaz que se presupone es la solo anfitrión, esta tiene que tener una direccion IP en la forma de `192.168.56.1XX`. Esta se obtiene automaticamente por DHCP.

Cuando verifiquen que su netplan esta correctamente configurado, pueden dar el comando.
```sh
sudo netplan apply
```

##### Que haya un adaptador "solo anfitrión" activo, asi como que este tenga el servidor DHCP activado.
- Abrir virtualbox
- Ir al hamburguer menu (el de las tres rayitas) situado dentro del boton "Herramientas" y dar click
- Seleccionar "Red"
- Verificar que haya un adaptador, y de no haberlo, crearlo.
- El adaptador tiene que tener una direccion IP, asi como el servidor DHCP activado como se muestra en la imagen.


#### Posible solucion para arreglar el DHCP (por confirmar).
Como se describe en [este post](https://forums.virtualbox.org/viewtopic.php?t=93035), la solucion es desactivar y activar el adaptador Solo Anfitrion en la sección de redes de Windows.

#### Solucion que funciona si o si.
Se le puede asignar una direccion IP estatica al host, esto debe forzar al adaptador a funcionar, asi como les permitira a ustedes tener una direccion la cual nunca cambiara a menos que ustedes asi lo deseen. Deben verificar antes [que haya un adaptador solo anfitrión configurado](#que-haya-un-adaptador-"solo-anfitrión"-activo,-asi-como-que-este-tenga-el-servidor-dhcp-activado.).

Esto lo logran abriendo el archivo `/etc/netplan/50-cloud-init.yaml` como super usuario con el comando:

```sh
sudo nano /etc/netplan/50-cloud-init.yaml
```

El archivo tiene que quedar de la siguiente manera:

```yaml
network:
    ethernets:
        enp0s3:
            dhcp4: true
        enp0s8:
            dhcp4: no
            addresses:
                - 192.168.56.20/24
            gateway4: 192.168.56.1
            
    version: 2
```

Siendo `enp0s8` su interfaz solo anfitrión.
