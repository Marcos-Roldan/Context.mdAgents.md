-- ============================================================================
-- SCRIPT 02: TRIGGER OBLIGATORIO PARA EL HISTORIAL AUTOMÁTICO DE PRECIOS
-- ============================================================================

USE gasolinera_dam;

DROP TRIGGER IF EXISTS trg_historial_precio;

DELIMITER //

CREATE TRIGGER trg_historial_precio
    BEFORE UPDATE ON producto
    FOR EACH ROW
BEGIN
    IF OLD.precio_venta <> NEW.precio_venta THEN
        INSERT INTO historial_precio (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
        VALUES (OLD.id, OLD.precio_venta, NEW.precio_venta, NOW());
    END IF;
END//

DELIMITER ;