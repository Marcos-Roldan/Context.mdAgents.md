package model;

import java.time.LocalDate;

public class Empleado {
    private int id;
    private String numeroInterno;
    private String documentoIdentidad;
    private String nombre;
    private String telefono;
    private String email;
    private LocalDate fechaIncorporacion;
    private Estacion estacion;
    private Empleado supervisor; // Supervisor opcional

    public Empleado(int id, String numeroInterno, String documentoIdentidad, String nombre, String telefono, String email, LocalDate fechaIncorporacion, Estacion estacion, Empleado supervisor) {
        this.id = id;
        this.numeroInterno = numeroInterno;
        this.documentoIdentidad = documentoIdentidad;
        this.nombre = nombre;
        this.telefono = telefono;
        this.email = email;
        this.fechaIncorporacion = fechaIncorporacion;
        this.estacion = estacion;
        this.supervisor = supervisor;
    }

    public int getId() { return id; }
    public String getNumeroInterno() { return numeroInterno; }
    public String getNombre() { return nombre; }
    public Empleado getSupervisor() { return supervisor; }
}