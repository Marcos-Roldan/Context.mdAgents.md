package model;

import java.time.LocalDateTime;

public class Incidencia {
    private int id;
    private LocalDateTime fechaHora;
    private String descripcion;
    private String estado; // ABIIERTA, RESUELTA
    private Estacion estacion;

    public Incidencia(int id, LocalDateTime fechaHora, String descripcion, String estado, Estacion estacion) {
        this.id = id;
        this.fechaHora = fechaHora;
        this.descripcion = descripcion;
        this.estado = estado;
        this.estacion = estacion;
    }

    public int getId() { return id; }
    public String getDescripcion() { return descripcion; }
}