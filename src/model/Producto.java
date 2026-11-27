package model;

public abstract class Producto {
    private int id;
    private String referenciaComercial;
    private String descripcion;
    private double precioVenta;
    private String estado; // 'ACTIVO', 'RETIRADO'

    public Producto(int id, String referenciaComercial, String descripcion, double precioVenta, String estado) {
        this.id = id;
        this.referenciaComercial = referenciaComercial;
        this.descripcion = descripcion;
        this.precioVenta = precioVenta;
        this.estado = estado;
    }

    // Método abstracto para validar la cantidad según la modalidad
    public abstract boolean validarCantidad(double cantidad);

    // Getters
    public double getPrecioVenta() { return precioVenta; }
    public String getDescripcion() { return descripcion; }
    public String getReferenciaComercial() { return referenciaComercial; }
}