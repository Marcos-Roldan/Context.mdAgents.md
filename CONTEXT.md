# CONTEXTO



###### Aplicación en Java para configurar una gasolinera conectada a una base de datos SQLite, con soporte para ejecutar datos en CSV y JSON.

###### 

###### ESTRUCTURA

###### 

###### RA2-JDBC/

###### └── Parte SQLite (Base de Datos)

###### &#x20;   ├── identifier.sqlite

###### &#x20;   ├── gasolinera.db

###### &#x20;   └── sql/

###### &#x20;       ├── 01\_esquema.sql

###### &#x20;       ├── 02\_triggers.sql

###### &#x20;       ├── 03\_datos.sql

###### &#x20;       └── 04\_comprobaciones.sql

###### 

###### RA2-JDBC/

###### └── Parte Java (Código y Datos)

###### &#x20;   ├── sqlite-jdbc-3.49.1.0.jar

###### &#x20;   ├── datos/

###### &#x20;   │   ├── clientes.json

###### &#x20;   │   └── pagos.json

###### &#x20;   └── src/

###### &#x20;       ├── Main.java

###### &#x20;       ├── Conexion.java

###### &#x20;       ├── ClienteDAO.java

###### &#x20;       ├── Pagos.java

###### &#x20;       ├── PagosDAO.java

###### &#x20;       ├── Almacenamiento.java

###### &#x20;       ├── AlmacenamientoJSON.java

###### &#x20;       ├── Almacenamiento\_EN\_CSV.java

###### &#x20;       ├── MigraCSVToJson.java

###### &#x20;       ├── Traductora.java

###### &#x20;       ├── PruebaModelo.java

###### &#x20;       └── model/

###### &#x20;           ├── Cliente.java

###### &#x20;           ├── ConfiguracionFacturacion.java

###### &#x20;           ├── Devolucion.java

###### &#x20;           ├── Empleado.java

###### &#x20;           ├── Estacion.java

###### &#x20;           ├── Incidencia.java

###### &#x20;           ├── LineaVenta.java

###### &#x20;           ├── Producto.java

###### &#x20;           ├── ProductoEnvasado.java

###### &#x20;           ├── ProductoGranel.java

###### &#x20;           ├── Proveedor.java

###### &#x20;           ├── Surtidor.java

###### &#x20;           └── Venta.java



Lo divido en Base de Datos SQLite para el almacenamiento y los scripts de SQL, y en Código Java para la lógica, DAO y todo organizado en carpetas.

