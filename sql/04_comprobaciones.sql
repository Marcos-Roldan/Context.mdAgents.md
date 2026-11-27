USE gasolinera_dam;

-- ============================================================================
-- SCRIPT 04: COMPROBACIONES, PRUEBAS Y ERRORES DELIBERADOS
-- ============================================================================

-- 1. CONSULTAS DE COMPROBACIÓN GENERAL (ÉXITO)
-- Comprobar estaciones y su configuración 1:1 estricta
SELECT e.codigo_interno, e.nombre_comercial, e.fecha_apertura, c.serie_ticket, c.texto_pie
FROM estacion e
         JOIN configuracion_facturacion c ON e.id_configuracion = c.id;

-- Comprobar productos y sus modalidades (Envasado vs Granel)
SELECT referencia_comercial, descripcion, modalidad, precio_venta, formato_envase, precision_pesada
FROM producto;

-- Comprobar ventas y sus líneas de detalle
SELECT v.referencia_ticket, l.numero_orden, p.descripcion, l.cantidad, l.precio_unitario_aplicado, l.importe_linea
FROM venta v
         JOIN linea_venta l ON v.id = l.id_venta
         JOIN producto p ON l.id_producto = p.id;


-- ============================================================================
-- 2. PRUEBA DEL TRIGGER DE HISTORIAL DE PRECIOS
-- ============================================================================
-- Ver estado actual del precio del producto 1 (Gasolina 95)
SELECT id, referencia_comercial, precio_venta FROM producto WHERE id = 1;

-- Actualización 1: Cambio real de precio (DEBE generar registro en historial)
UPDATE producto SET precio_venta = 1.719 WHERE id = 1;

-- Actualización 2: Guardar el mismo precio (NO debe generar registro en historial)
UPDATE producto SET precio_venta = 1.719 WHERE id = 1;

-- Actualización 3: Cambiar solo la descripción (NO debe generar registro en historial)
UPDATE producto SET descripcion = 'Gasolina sin plomo 95 octanos optimizada' WHERE id = 1;

-- Comprobar la tabla de histórico (Debe mostrar exactamente 1 entrada con el cambio anterior)
SELECT * FROM historial_precio WHERE id_producto = 1;


-- ============================================================================
-- 3. PRUEBAS DE ERRORES DELIBERADOS (DEBEN FALLAR)
-- Nota: Ejecuta estas sentencias de una en una para poder comprobar cada error.
-- ============================================================================

-- INTENTO A: Violación de clave única (Duplicar DNI de empleado)
-- Resultado esperado: Error 1062 (Duplicate entry for key 'empleado.documento_identidad')
INSERT INTO empleado (numero_interno, documento_identidad, nombre, telefono, email, fecha_incorporacion, id_estacion)
VALUES ('EMP-999', '12345678A', 'Prueba Duplicado', '600000000', 'error@email.com', '2026-01-01', 1);

-- INTENTO B: Violación de restricción CHECK (Precio de venta negativo o cero)
-- Resultado esperado: Error por incumplimiento de la restricción 'chk_precio_positivo'
INSERT INTO producto (referencia_comercial, descripcion, precio_venta, estado, modalidad, formato_envase)
VALUES ('PROD-ERR', 'Producto erróneo', -2.50, 'ACTIVO', 'ENVASADO', 'Unidad');

-- INTENTO C: Violación de clave foránea (Asignar surtidor a una estación inexistente)
-- Resultado esperado: Error 1452 (Cannot add or update a child row: a foreign key constraint fails)
INSERT INTO surtidor (codigo_equipo, numero_visible, tipo_combustible, estado_servicio, id_estacion)
VALUES ('SURT-99', 99, 'Gasolina', 'OPERATIVO', 9999);