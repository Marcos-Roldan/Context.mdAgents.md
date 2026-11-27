package model;

public class ProductoEnvasado extends Producto {
    private String formatoEnvase;

    public ProductoEnvasado(int id, String ref, String desc, double precio, String estado, String formatoEnvase) {
        super(id, ref, desc, precio, estado);
        this.formatoEnvase = formatoEnvase;
    }

    @Override
    public boolean validarCantidad(double cantidad) {
        // Exige unidades enteras positivas (ej. 1, 2, 5... no permite 1.5)
        return cantidad > 0 && cantidad == Math.floor(cantidad);
    }
}