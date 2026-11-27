package model;

public class LineaVenta {
    private int id;
    private int numeroOrden;
    private Venta venta;
    private Producto producto;
    private double cantidad;
    private double precioUnitarioAplicado;
    private double importeLinea;

    public LineaVenta(int id, int numeroOrden, Venta venta, Producto producto, double cantidad, double precioUnitarioAplicado) {
        this.id = id;
        this.numeroOrden = numeroOrden;
        this.venta = venta;
        this.producto = producto;
        this.cantidad = cantidad;
        this.precioUnitarioAplicado = precioUnitarioAplicado;
        // Calculamos el importe automáticamente aplicando la regla
        this.importeLinea = cantidad * precioUnitarioAplicado;
    }

    public int getId() { return id; }
    public double getCantidad() { return cantidad; }
    public double getImporteLinea() { return importeLinea; }
}