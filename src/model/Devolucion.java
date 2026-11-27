package model;

import java.time.LocalDateTime;

public class Devolucion {
    private int id;
    private LocalDateTime fechaHora;
    private String motivo;
    private double importeDevuelto;
    private Venta venta;

    public Devolucion(int id, LocalDateTime fechaHora, String motivo, double importeDevuelto, Venta venta) {
        this.id = id;
        this.fechaHora = fechaHora;
        this.motivo = motivo;
        this.importeDevuelto = importeDevuelto;
        this.venta = venta;
    }

    public int getId() { return id; }
    public double getImporteDevuelto() { return importeDevuelto; }
}