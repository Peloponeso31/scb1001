# Agregar un directorio a la variable de entorno `Path`
- Presionar la tecla windows.
- Escribir "path" sin las comillas.
- Dar clck en "Editar las variables de entorno del sistema", si no aparece esto al escribir "path", buscarlo directamente.

![image](https://github.com/user-attachments/assets/fb13e532-69fe-4c62-83c2-ab426c8aa014)

- Dar click en el boton Variables de entorno.

![image](https://github.com/user-attachments/assets/ca5f4117-e929-42ed-b54b-d5462a88233f)

- En la seccion de "Sistema", dar click en "PATH".

![image](https://github.com/user-attachments/assets/7ec03fe7-7327-42cf-acc7-59770c43e4e4)

- Dar click en el boton de "Editar".
- Dar en el boton "Nuevo".

![image](https://github.com/user-attachments/assets/1652de67-da0b-4c52-9590-b0e3f69acade)

- Buscar la instalacion del cliente de MariaDB, usualmente se encuentra en `C:\Program Files\MariaDB XX.X\bin`, notese las "X", la version puede ser distinta para cada uno de ustedes, deben de navegar a la ruta descrita y copiar esta.
- Pegar la ruta previamente copiada en la ventana de Editar Variable de Entorno.
- Dar "Aceptar" en todas las ventanas.
- Abrir una nueva terminal/cmd/powershell.
- Escribir en la terminal "mysql --version" o "mariadb --version" sin las comillas.
- Si la salida es similar a la de la siguiente imagen, el cliente de MariaDB esta instalado con exito.
![image](https://github.com/user-attachments/assets/e3d327c4-480c-4e1f-b6e8-c514d0ffc61f)
