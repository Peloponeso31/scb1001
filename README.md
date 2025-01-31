# Curso de Administración de Base de Datos [SCB-1001].
## Objetivo del curso.
Esta asignatura esta orientada a capacitar a los estudiantes en la selección, implementación y administración de sistemas de gestión de bases de datos (SGBD), con el fin de optimizar el almacenamiento, organización y acceso a la información en entornos organizacionales.

## Requisitos del alumno.
### Requisitos materiales.
- El alumno deberá contar con un equipo de cómputo capaz de ejecutar máquinas virtuales.
- Se recomienda el uso de [Oracle VirtualBox](https://www.virtualbox.org/) como virtualizador, sin embargo, la elección queda a criterio del alumno, siempre que se cumplan los requisitos de red.
- A lo largo del curso, se utilizará la distribución Linux [Ubuntu Server](https://ubuntu.com/download/server#manual-install) en su version mas reciente. No obstante, los alumnos con experiencia previa en otra distribución pueden optar por utilizarla.
- El sistema operativo de la computadora del alumno puede ser cualquiera. Sin embargo, será responsabilidad del estudiante investigar cómo realizar determinadas tareas en su entorno.

### Requisitos de red.
Es necesario disponer de una máquina virtual con acceso a internet y conexión a una red virtual interna. Esto permitirá la publicación de servicios y la creación de un homelab virtual.
Además, la máquina debe contar con un servicio de MariaDB configurado para brindar acceso en red, así como SSH habilitado para permitir la administración remota.
![Untitled-2025-01-30-2107](https://github.com/user-attachments/assets/8e13a4ba-e2fc-430d-b548-c54822adcd5c)

El adaptador "Solo Anfitrión" (Host-Only Adapter) de VirtualBox permite crear una red virtual aislada. La siguiente gráfica muestra la arquitectura de red recomendada para esta interfaz, en caso de utilizar un hipervisor diferente a VirtualBox.
![Untitled-2025-01-30-2107(1)](https://github.com/user-attachments/assets/477a9e1d-9d69-4f70-9445-cdc8c0ed9c09)
