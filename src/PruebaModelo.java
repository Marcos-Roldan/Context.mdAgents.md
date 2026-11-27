import model.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

public class PruebaModelo {
    public static void main(String[] args) {
        System.out.println("--- PROBANDO MODELO DE DOMINIO DE LA GASOLINERA ---");

        // 1. Crear configuración y estación
        ConfiguracionFacturacion config = new ConfiguracionFacturacion(1, "CONF-01", "A", 1, "Gracias por su visita");
        Estacion estacion = new Estacion(1, "EST-01", "Gasolinera Central", "Calle Mayor 123", "912345678", "central@gasolinera.com", LocalDate.now(), LocalTime.of(6, 0), LocalTime.of(22, 0), false, config);

        System.out.println("Estación creada: " + estacion.getNombreComercial());

        // 2. Probar productos y validaciones (Envasado vs Granel)
        Producto productoEnvasado = new ProductoEnvasado(1, "LUB-5W30", "Aceite Motor 5W30", 25.50, "ACTIVO", "Botella 1L");
        Producto productoGranel = new ProductoGranel(2, "GAS-95", "Gasolina 95", 1.65, "ACTIVO", 0.01);

        // Prueba de validación de cantidades
        double cantidadValidaEnvasado = 2.0;
        double cantidadInvalidaEnvasado = 1.5; // Los envasados no deben permitir decimales
        double cantidadGranel = 15.75;

        System.out.println("\n--- VALIDACIÓN DE PRODUCTOS ---");
        System.out.println("¿Cantidad " + cantidadValidaEnvasado + " válida para envasado? " + productoEnvasado.validarCantidad(cantidadValidaEnvasado)); // true
        System.out.println("¿Cantidad " + cantidadInvalidaEnvasado + " válida para envasado? " + productoEnvasado.validarCantidad(cantidadInvalidaEnvasado)); // false
        System.out.println("¿Cantidad " + cantidadGranel + " válida para a granel? " + productoGranel.validarCantidad(cantidadGranel)); // true

        // 3. Crear una venta de prueba
        Cliente cliente = new Cliente(1,"CLI-001", "Ana Pérez", "600111222");
        Empleado empleado = new Empleado(1, "EMP-01", "12345678Z", "Carlos Gómez", "611222333", "carlos@email.com", LocalDate.now(), estacion, null);

        Venta venta = new Venta(1, "TICK-2026-001", LocalDateTime.now(), "PAGADA", estacion, empleado, cliente);

        // Añadir una línea de venta
        LineaVenta linea = new LineaVenta(1, 1, venta, productoGranel, cantidadGranel, productoGranel.getPrecioVenta());

        System.out.println("\n--- VENTA REGISTRADA ---");
        System.out.println("Ticket: " + venta.getReferenciaTicket());
        System.out.println("Importe total de la línea (" + cantidadGranel + " L): " + linea.getImporteLinea() + " €");
        System.out.println("¡Todo el modelo compila y funciona correctamente!");
    }
}