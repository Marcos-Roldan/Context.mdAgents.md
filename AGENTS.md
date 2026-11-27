### OBJETIVO



Desarrollo una aplicación en Java para gestionar la conexión y las operaciones mediante JDBC con la base de datos SQLite para el proyecto de la gasolinera, implementando el patrón DAO y manipulación de datos.





### INSTRUCCIONES



Cargo y configuro el proyecto y el driver JDBC en mi entorno de desarrollo.



Ejecuto los scripts SQL proporcionados para crear el esquema, los triggers y cargar los datos iniciales en la base de datos SQLite (gasolinera.db).



Utilizar y probar las clases de acceso a datos (ClienteDAO, PagosDAO) y las utilidades de almacenamiento en formatos JSON y CSV.



Cualquier duda o alguna contradicción me preguntara o me corregirá.





### ENTORNO DE DESARROLLO

###### 

Lenguaje: Java



Base de Datos: SQLite (gasolinera.db)



Conectividad: Driver SQLite JDBC (archivo .jar)



IDE: IntelliJ IDEA





### Permisos



Permisos de lectura, escritura y ejecución para la gestión de archivos y base de datos SQLite.



Control de acceso mediante el patrón DAO.



Acceso a la lectura y escritura de ficheros de datos JSON y CSV.

### 

### Preguntas o dudas que me ha ido haciendo



1. ¿Cómo prefieres que se implemente la importación y exportación de datos en formato JSON y CSV? (Guardar y leer archivos de gasolinera)



2\. ¿Cómo prefieres que se gestione la conexión con la base de datos SQLite en las clases DAO?



3\. ¿Cómo prefieres que se implemente el control de transacciones en operaciones críticas (como registrar ventas, pagos o devoluciones)?





### Respuestas dadas por mi



1. Yo quiero que el programa le pida los datos al SQLite usando los DAO, SQLite se lo entrega al AlmacenaminetoJSON que coge esos datos que le da SQLite y los escribe de forma ordenada en clientes.json y pagos.json



2\. Una única conexión donde se ejecute todo el programa, tanto el JDBC como el JSON como el JAVA. Tanto JAVA como los DAO hablan con SQLite y las clases que    leen y escriben los archivos JSON y CSV. Todos se apoyan en la misma conexión para luego comunicarse con la base de datos.



3\. JAVA se centra en el autocommit, es decir, lanzar las consulas y las operaciones. SQLite se centra en los triggers o tablas (CREATE TABLE).

