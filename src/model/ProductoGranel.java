package model;

public class ProductoGranel extends Producto {
    private double precisionPesada;

    public ProductoGranel(int id, String ref, String desc, double precio, String estado, double precisionPesada) {
        super(id, ref, desc, precio, estado);
        this.precisionPesada = precisionPesada;
    }

    @Override
    public boolean validarCantidad(double cantidad) {
        // Los productos a granel admiten decimales positivos
        return cantidad > 0;
    }
}