-- ============================================================================
-- SCRIPT 01: CREACIÓN DEL ESQUEMA DE BASE DE DATOS (GASOLINERA + TIENDA)
-- Motor: InnoDB | Codificación: utf8mb4
-- ============================================================================

DROP DATABASE IF EXISTS gasolinera_dam;
CREATE DATABASE gasolinera_dam CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gasolinera_dam;

-- 1. ESTACIONES, CONFIGURACIÓN DE FACTURACIÓN Y SURTIDORES
CREATE TABLE configuracion_facturacion (
                                           id INT AUTO_INCREMENT PRIMARY KEY,
                                           codigo_configuracion VARCHAR(30) NOT NULL UNIQUE,
                                           serie_ticket VARCHAR(10) NOT NULL,
                                           siguiente_numero INT NOT NULL DEFAULT 1,
                                           texto_pie VARCHAR(255) NOT NULL,
                                           CONSTRAINT chk_siguiente_num CHECK (siguiente_numero >= 1)
) ENGINE=InnoDB;

CREATE TABLE estacion (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          codigo_interno VARCHAR(20) NOT NULL UNIQUE,
                          nombre_comercial VARCHAR(100) NOT NULL,
                          direccion VARCHAR(200) NOT NULL,
                          telefono VARCHAR(20) NOT NULL,
                          email VARCHAR(100) NOT NULL,
                          fecha_apertura DATE NOT NULL,           -- <--- ¡Esta línea es la que faltaba!
                          hora_apertura TIME NOT NULL,
                          hora_cierre TIME NOT NULL,
                          abierta_24h TINYINT(1) NOT NULL DEFAULT 0,
                          id_configuracion INT NOT NULL UNIQUE,   -- <--- Añadido UNIQUE para el 1:1 estricto
                          CONSTRAINT fk_estacion_config
                              FOREIGN KEY (id_configuracion) REFERENCES configuracion_facturacion(id)
                                  ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE surtidor (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          codigo_equipo VARCHAR(30) NOT NULL UNIQUE,
                          numero_visible INT NOT NULL,
                          tipo_combustible VARCHAR(40) NOT NULL,
                          estado_servicio ENUM('OPERATIVO', 'AVERIADO', 'MANTENIMIENTO') NOT NULL DEFAULT 'OPERATIVO',
                          id_estacion INT NOT NULL,
                          CONSTRAINT uq_surtidor_estacion_num UNIQUE (id_estacion, numero_visible),
                          CONSTRAINT fk_surtidor_estacion
                              FOREIGN KEY (id_estacion) REFERENCES estacion(id)
                                  ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 2. PERSONAL, SUPERVISIÓN Y FUNCIONES
CREATE TABLE empleado (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          numero_interno VARCHAR(20) NOT NULL UNIQUE,
                          documento_identidad VARCHAR(20) NOT NULL UNIQUE,
                          nombre VARCHAR(100) NOT NULL,
                          telefono VARCHAR(20) NOT NULL,
                          email VARCHAR(100) NOT NULL,
                          fecha_incorporacion DATE NOT NULL,
                          id_estacion INT NOT NULL,
                          id_supervisor INT NULL,
                          CONSTRAINT fk_empleado_estacion
                              FOREIGN KEY (id_estacion) REFERENCES estacion(id)
                                  ON DELETE RESTRICT ON UPDATE CASCADE,
                          CONSTRAINT fk_empleado_supervisor
                              FOREIGN KEY (id_supervisor) REFERENCES empleado(id)
                                  ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE asignacion_funcion (
                                    id INT AUTO_INCREMENT PRIMARY KEY,
                                    id_empleado INT NOT NULL,
                                    tipo_funcion ENUM('CAJERO', 'EXPENDEDOR', 'RESPONSABLE_TIENDA', 'JEFE_ESTACION') NOT NULL,
                                    fecha_inicio DATE NOT NULL,
                                    fecha_fin DATE NULL,
                                    limite_devolucion DECIMAL(10,2) NULL,
                                    num_acreditacion VARCHAR(40) NULL,
                                    caducidad_acreditacion DATE NULL,
                                    presupuesto_compras DECIMAL(10,2) NULL,
                                    nivel_autorizacion INT NULL,
                                    CONSTRAINT chk_fechas_funcion CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
                                    CONSTRAINT fk_asignacion_empleado
                                        FOREIGN KEY (id_empleado) REFERENCES empleado(id)
                                            ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 3. CLIENTES Y TARJETAS
CREATE TABLE cliente (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         codigo_cliente VARCHAR(20) NOT NULL UNIQUE,
                         nombre VARCHAR(100) NOT NULL,
                         telefono VARCHAR(20) NULL,
                         email VARCHAR(100) NULL
) ENGINE=InnoDB;

CREATE TABLE tarjeta_fidelizacion (
                                      id INT AUTO_INCREMENT PRIMARY KEY,
                                      numero_tarjeta VARCHAR(30) NOT NULL UNIQUE,
                                      fecha_emision DATE NOT NULL,
                                      fecha_asignacion DATE NULL,
                                      id_cliente INT NULL UNIQUE,
                                      CONSTRAINT chk_fecha_tarjeta CHECK (fecha_asignacion IS NULL OR fecha_asignacion >= fecha_emision),
                                      CONSTRAINT fk_tarjeta_cliente
                                          FOREIGN KEY (id_cliente) REFERENCES cliente(id)
                                              ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. CATÁLOGO DE PRODUCTOS Y PROVEEDORES
CREATE TABLE producto (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          referencia_comercial VARCHAR(30) NOT NULL UNIQUE,
                          descripcion VARCHAR(150) NOT NULL,
                          precio_venta DECIMAL(10,2) NOT NULL,
                          estado ENUM('ACTIVO', 'RETIRADO') NOT NULL DEFAULT 'ACTIVO',
                          modalidad ENUM('ENVASADO', 'GRANEL') NOT NULL,
                          formato_envase VARCHAR(50) NULL,
                          precision_pesada DECIMAL(5,3) NULL,
                          CONSTRAINT chk_precio_positivo CHECK (precio_venta > 0),
                          CONSTRAINT chk_modalidad_datos CHECK (
                              (modalidad = 'ENVASADO' AND formato_envase IS NOT NULL AND precision_pesada IS NULL) OR
                              (modalidad = 'GRANEL' AND precision_pesada IS NOT NULL AND precision_pesada > 0 AND formato_envase IS NULL)
                              )
) ENGINE=InnoDB;

CREATE TABLE historial_precio (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  id_producto INT NOT NULL,
                                  precio_anterior DECIMAL(10,2) NOT NULL,
                                  precio_nuevo DECIMAL(10,2) NOT NULL,
                                  fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  CONSTRAINT fk_historial_producto
                                      FOREIGN KEY (id_producto) REFERENCES producto(id)
                                          ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE proveedor (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           codigo_interno VARCHAR(20) NOT NULL UNIQUE,
                           nif VARCHAR(20) NOT NULL UNIQUE,
                           razon_social VARCHAR(120) NOT NULL,
                           telefono VARCHAR(20) NOT NULL,
                           email VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE acuerdo_suministro (
                                    id INT AUTO_INCREMENT PRIMARY KEY,
                                    id_proveedor INT NOT NULL,
                                    id_producto INT NOT NULL,
                                    referencia_proveedor VARCHAR(40) NOT NULL,
                                    precio_compra DECIMAL(10,2) NOT NULL,
                                    plazo_entrega_dias INT NOT NULL,
                                    CONSTRAINT chk_precio_compra CHECK (precio_compra > 0),
                                    CONSTRAINT chk_plazo_entrega CHECK (plazo_entrega_dias >= 0),
                                    CONSTRAINT uq_proveedor_producto UNIQUE (id_proveedor, id_producto),
                                    CONSTRAINT fk_acuerdo_proveedor
                                        FOREIGN KEY (id_proveedor) REFERENCES proveedor(id)
                                            ON DELETE RESTRICT ON UPDATE CASCADE,
                                    CONSTRAINT fk_acuerdo_producto
                                        FOREIGN KEY (id_producto) REFERENCES producto(id)
                                            ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. CAMPAÑAS PROMOCIONALES
CREATE TABLE campana (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         codigo_campana VARCHAR(20) NOT NULL UNIQUE,
                         nombre VARCHAR(100) NOT NULL,
                         descripcion TEXT NULL,
                         fecha_inicio DATE NOT NULL,
                         fecha_fin DATE NOT NULL,
                         CONSTRAINT chk_fechas_campana CHECK (fecha_fin >= fecha_inicio)
) ENGINE=InnoDB;

CREATE TABLE inscripcion_campana (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     id_cliente INT NOT NULL,
                                     id_campana INT NOT NULL,
                                     fecha_inscripcion DATE NOT NULL,
                                     CONSTRAINT uq_cliente_campana UNIQUE (id_cliente, id_campana),
                                     CONSTRAINT fk_inscripcion_cliente
                                         FOREIGN KEY (id_cliente) REFERENCES cliente(id)
                                             ON DELETE RESTRICT ON UPDATE CASCADE,
                                     CONSTRAINT fk_inscripcion_campana
                                         FOREIGN KEY (id_campana) REFERENCES campana(id)
                                             ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6. VENTAS, LÍNEAS, PAGOS Y DEVOLUCIONES
CREATE TABLE venta (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       referencia_ticket VARCHAR(30) NOT NULL UNIQUE,
                       fecha_hora DATETIME NOT NULL,
                       estado ENUM('ABIERTA', 'PAGADA', 'ANULADA') NOT NULL DEFAULT 'ABIERTA',
                       id_estacion INT NOT NULL,
                       id_empleado INT NOT NULL,
                       id_cliente INT NULL,
                       CONSTRAINT fk_venta_estacion
                           FOREIGN KEY (id_estacion) REFERENCES estacion(id)
                               ON DELETE RESTRICT ON UPDATE CASCADE,
                       CONSTRAINT fk_venta_empleado
                           FOREIGN KEY (id_empleado) REFERENCES empleado(id)
                               ON DELETE RESTRICT ON UPDATE CASCADE,
                       CONSTRAINT fk_venta_cliente
                           FOREIGN KEY (id_cliente) REFERENCES cliente(id)
                               ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE linea_venta (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             id_venta INT NOT NULL,
                             numero_orden INT NOT NULL,
                             id_producto INT NOT NULL,
                             cantidad DECIMAL(10,3) NOT NULL,
                             precio_unitario_aplicado DECIMAL(10,3) NOT NULL, -- <--- Cambiado a 3 decimales
                             importe_linea DECIMAL(10,2) NOT NULL,
                             CONSTRAINT chk_cantidad_positiva CHECK (cantidad > 0),
                             CONSTRAINT chk_precio_linea CHECK (precio_unitario_aplicado > 0),
                             CONSTRAINT chk_importe_linea CHECK (importe_linea > 0),
                             CONSTRAINT uq_venta_orden UNIQUE (id_venta, numero_orden),
                             CONSTRAINT fk_linea_venta
                                 FOREIGN KEY (id_venta) REFERENCES venta(id)
                                     ON DELETE RESTRICT ON UPDATE CASCADE,
                             CONSTRAINT fk_linea_producto
                                 FOREIGN KEY (id_producto) REFERENCES producto(id)
                                     ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pago (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      id_venta INT NOT NULL,
                      fecha_hora DATETIME NOT NULL,
                      importe DECIMAL(10,2) NOT NULL,
                      medio_pago ENUM('EFECTIVO', 'TARJETA', 'BIZUM', 'VALE') NOT NULL,
                      referencia_operacion VARCHAR(50) NULL,
                      CONSTRAINT chk_importe_pago CHECK (importe > 0),
                      CONSTRAINT fk_pago_venta
                          FOREIGN KEY (id_venta) REFERENCES venta(id)
                              ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE devolucion (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            id_linea_venta INT NOT NULL,
                            id_empleado INT NOT NULL,
                            fecha_hora DATETIME NOT NULL,
                            cantidad_devuelta DECIMAL(10,3) NOT NULL,
                            importe_reintegrado DECIMAL(10,2) NOT NULL,
                            motivo VARCHAR(200) NOT NULL,
                            apta_reventa BOOLEAN NOT NULL DEFAULT FALSE,
                            CONSTRAINT chk_cant_devuelta CHECK (cantidad_devuelta > 0),
                            CONSTRAINT chk_imp_reintegrado CHECK (importe_reintegrado > 0),
                            CONSTRAINT fk_devolucion_linea
                                FOREIGN KEY (id_linea_venta) REFERENCES linea_venta(id)
                                    ON DELETE RESTRICT ON UPDATE CASCADE,
                            CONSTRAINT fk_devolucion_empleado
                                FOREIGN KEY (id_empleado) REFERENCES empleado(id)
                                    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. INCIDENCIAS DE TRABAJO
CREATE TABLE incidencia (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            referencia VARCHAR(30) NOT NULL UNIQUE,
                            descripcion TEXT NOT NULL,
                            fecha_apertura DATETIME NOT NULL,
                            estado ENUM('ABIERTA', 'EN_CURSO', 'RESUELTA', 'CERRADA') NOT NULL DEFAULT 'ABIERTA',
                            id_estacion INT NOT NULL,
                            id_empleado_responsable INT NULL,
                            CONSTRAINT fk_incidencia_estacion
                                FOREIGN KEY (id_estacion) REFERENCES estacion(id)
                                    ON DELETE RESTRICT ON UPDATE CASCADE,
                            CONSTRAINT fk_incidencia_empleado
                                FOREIGN KEY (id_empleado_responsable) REFERENCES empleado(id)
                                    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;