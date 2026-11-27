package model;

import java.time.LocalDateTime;

public class Venta {
    private int id;
    private String referenciaTicket;
    private LocalDateTime fechaHora;
    private String estado; // ABIERTA, PAGADA, ANULADA
    private Estacion estacion;
    private Empleado empleado;
    private Cliente cliente; // Opcional (puede ser venta anónima)

    public Venta(int id, String referenciaTicket, LocalDateTime fechaHora, String estado, Estacion estacion, Empleado empleado, Cliente cliente) {
        this.id = id;
        this.referenciaTicket = referenciaTicket;
        this.fechaHora = fechaHora;
        this.estado = estado;
        this.estacion = estacion;
        this.empleado = empleado;
        this.cliente = cliente;
    }

    public int getId() { return id; }
    public String getReferenciaTicket() { return referenciaTicket; }
    public LocalDateTime getFechaHora() { return fechaHora; }
    public String getEstado() { return estado; }
    public Estacion getEstacion() { return estacion; }
    public Empleado getEmpleado() { return empleado; }
    public Cliente getCliente() { return cliente; }
}