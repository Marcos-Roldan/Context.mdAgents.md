USE gasolinera_dam;

-- Desactivar temporalmente restricciones para permitir la inserción limpia
SET FOREIGN_KEY_CHECKS = 0;

-- Limpieza previa de datos en orden seguro
TRUNCATE TABLE incidencia;
TRUNCATE TABLE devolucion;
TRUNCATE TABLE pago;
TRUNCATE TABLE linea_venta;
TRUNCATE TABLE venta;
TRUNCATE TABLE inscripcion_campana;
TRUNCATE TABLE campana;
TRUNCATE TABLE acuerdo_suministro;
TRUNCATE TABLE proveedor;
TRUNCATE TABLE historial_precio;
TRUNCATE TABLE producto;
TRUNCATE TABLE tarjeta_fidelizacion;
TRUNCATE TABLE cliente;
TRUNCATE TABLE asignacion_funcion;
TRUNCATE TABLE empleado;
TRUNCATE TABLE surtidor;
TRUNCATE TABLE estacion;
TRUNCATE TABLE configuracion_facturacion;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. CONFIGURACIÓN DE FACTURACIÓN
INSERT INTO configuracion_facturacion (id, codigo_configuracion, serie_ticket, siguiente_numero, texto_pie) VALUES
    (1, 'CONF-01', 'A', 1, 'Gracias por su visita - Vuelva pronto');

-- 2. ESTACIONES (Añadida fecha_apertura y id_configuracion único)
INSERT INTO estacion (id, codigo_interno, nombre_comercial, direccion, telefono, email, fecha_apertura, hora_apertura, hora_cierre, abierta_24h, id_configuracion) VALUES
    (1, 'EST-MAD-01', 'Estación Central Madrid', 'Calle de Alcalá 120, Madrid', '911223344', 'central@gasolinerasdam.com', '2020-01-10', '06:00:00', '22:00:00', 0, 1);

-- 3. SURTIDORES (Adaptado a columnas reales: codigo_equipo, numero_visible, tipo_combustible, estado_servicio)
INSERT INTO surtidor (id, codigo_equipo, numero_visible, tipo_combustible, estado_servicio, id_estacion) VALUES
                                                                                                             (1, 'SURT-01', 1, 'Gasolina 95', 'OPERATIVO', 1),
                                                                                                             (2, 'SURT-02', 2, 'Gasóleo A', 'OPERATIVO', 1);

-- 4. EMPLEADOS
INSERT INTO empleado (id, numero_interno, documento_identidad, nombre, telefono, email, fecha_incorporacion, id_estacion, id_supervisor) VALUES
                                                                                                                                             (1, 'EMP-001', '12345678A', 'Carlos Gómez Pérez', '600112233', 'carlos.gomez@gasolinerasdam.com', '2023-01-15', 1, NULL),
                                                                                                                                             (2, 'EMP-002', '87654321B', 'Ana Martínez Ruiz', '600223344', 'ana.martinez@gasolinerasdam.com', '2023-03-01', 1, 1);

-- 5. ASIGNACIÓN FUNCIÓN (Adaptado a la tabla de histórico de funciones)
INSERT INTO asignacion_funcion (id_empleado, tipo_funcion, fecha_inicio, fecha_fin, limite_devolucion) VALUES
                                                                                                           (1, 'JEFE_ESTACION', '2023-01-15', NULL, NULL),
                                                                                                           (2, 'CAJERO', '2023-03-01', NULL, 150.00);

-- 6. CLIENTES (Adaptado a codigo_cliente, nombre, telefono, email)
INSERT INTO cliente (id, codigo_cliente, nombre, telefono, email) VALUES
                                                                      (1, 'CLI-001', 'Juan Pérez García', '611223344', 'juan.perez@email.com'),
                                                                      (2, 'CLI-002', 'Transportes Madrid S.L.', '913445566', 'contacto@transmadrid.com');

-- 7. TARJETA FIDELIZACIÓN (Adaptado a numero_tarjeta, fecha_emision, fecha_asignacion, id_cliente)
INSERT INTO tarjeta_fidelizacion (id, numero_tarjeta, fecha_emision, fecha_asignacion, id_cliente) VALUES
                                                                                                       (1, 'TF-001', '2023-05-20', '2023-05-20', 1),
                                                                                                       (2, 'TF-002', '2023-07-10', NULL, NULL); -- Tarjeta sin asignar como exige el caso

-- 8. PRODUCTOS (Adaptado a modalidad, formato_envase o precision_pesada)
INSERT INTO producto (id, referencia_comercial, descripcion, precio_venta, estado, modalidad, formato_envase, precision_pesada) VALUES
                                                                                                                                    (1, 'PROD-95', 'Gasolina sin plomo 95 octanos', 1.659, 'ACTIVO', 'GRANEL', NULL, 0.001),
                                                                                                                                    (2, 'PROD-DSL', 'Gasóleo de automoción habitual', 1.589, 'ACTIVO', 'GRANEL', NULL, 0.001),
                                                                                                                                    (3, 'PROD-ACE', 'Garrafa de aceite sintético 5L', 29.99, 'ACTIVO', 'ENVASADO', 'Garrafa 5 Litros', NULL);

-- 9. HISTORIAL PRECIO (Sin columna motivo que no existe en el esquema)
INSERT INTO historial_precio (id_producto, precio_anterior, precio_nuevo, fecha_cambio) VALUES
    (1, 1.629, 1.659, '2026-01-01 00:00:00');

-- 10. PROVEEDOR (Adaptado a codigo_interno, nif, razon_social)
INSERT INTO proveedor (id, codigo_interno, nif, razon_social, telefono, email) VALUES
                                                                                   (1, 'PROV-01', 'B12345678', 'Petróleos Peninsulares S.A.', '915667788', 'ventas@petroleospeninsulares.com'),
                                                                                   (2, 'PROV-02', 'B87654321', 'Lubricantes y Accesorios S.L.', '916778899', 'pedidos@lubricantes.com');

-- 11. ACUERDO SUMINISTRO
INSERT INTO acuerdo_suministro (id_proveedor, id_producto, referencia_proveedor, precio_compra, plazo_entrega_dias) VALUES
                                                                                                                        (1, 1, 'REF-PET-95', 1.450, 2),
                                                                                                                        (2, 3, 'REF-LUB-ACE', 21.50, 5);

-- 12. CAMPAÑAS
INSERT INTO campana (id, codigo_campana, nombre, descripcion, fecha_inicio, fecha_fin) VALUES
    (1, 'CAMP-01', 'Verano Ahorro 2026', 'Descuento en combustibles durante meses de verano', '2026-06-01', '2026-08-31');

-- 13. INSCRIPCIÓN CAMPAÑA
INSERT INTO inscripcion_campana (id_cliente, id_campana, fecha_inscripcion) VALUES
    (1, 1, '2026-06-05');

-- 14. VENTAS
INSERT INTO venta (id, referencia_ticket, fecha_hora, estado, id_estacion, id_empleado, id_cliente) VALUES
                                                                                                        (1, 'TICK-0001', '2026-06-10 10:30:00', 'PAGADA', 1, 2, 1),
                                                                                                        (2, 'TICK-0002', '2026-06-10 11:15:00', 'PAGADA', 1, 2, NULL); -- Venta anónima

-- 15. LÍNEAS DE VENTA (Adaptado a precio_unitario_aplicado e importe_linea)
INSERT INTO linea_venta (id_venta, numero_orden, id_producto, cantidad, precio_unitario_aplicado, importe_linea) VALUES
                                                                                                                     (1, 1, 1, 40.000, 1.659, 66.36),
                                                                                                                     (1, 2, 3, 1.000, 29.99, 29.99),
                                                                                                                     (2, 1, 2, 50.000, 1.589, 79.45);

-- 16. PAGOS (Adaptado a referencia_operacion)
INSERT INTO pago (id_venta, fecha_hora, importe, medio_pago, referencia_operacion) VALUES
                                                                                       (1, '2026-06-10 10:31:00', 96.35, 'TARJETA', 'TX-998877'),
                                                                                       (2, '2026-06-10 11:16:00', 79.45, 'EFECTIVO', NULL);

-- 17. DEVOLUCIONES (Añadido importe_reintegrado obligatorio)
INSERT INTO devolucion (id_linea_venta, id_empleado, fecha_hora, cantidad_devuelta, importe_reintegrado, motivo, apta_reventa) VALUES
    (2, 2, '2026-06-11 09:00:00', 1.000, 29.99, 'Defecto de fábrica en el envase', FALSE);

-- 18. INCIDENCIAS (Corregido id_empleado_responsable y estado 'EN_CURSO')
INSERT INTO incidencia (referencia, descripcion, fecha_apertura, estado, id_estacion, id_empleado_responsable) VALUES
                                                                                                                   ('INC-001', 'Surtidor 1 con manguera lenta', '2026-03-01 08:00:00', 'ABIERTA', 1, 1),
                                                                                                                   ('INC-002', 'Fallo temporal en datáfono', '2026-03-02 14:30:00', 'RESUELTA', 1, 2);