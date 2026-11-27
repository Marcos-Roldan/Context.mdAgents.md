package model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Estacion {
    private int id;
    private String codigoInterno;
    private String nombreComercial;
    private String direccion;
    private String telefono;
    private String email;
    private LocalDate fechaApertura;
    private LocalTime horaApertura;
    private LocalTime horaCierre;
    private boolean abierta24h;
    private ConfiguracionFacturacion configuracionFacturacion; // Relación 1:1

    public Estacion(int id, String codigoInterno, String nombreComercial, String direccion, String telefono, String email, LocalDate fechaApertura, LocalTime horaApertura, LocalTime horaCierre, boolean abierta24h, ConfiguracionFacturacion configuracionFacturacion) {
        this.id = id;
        this.codigoInterno = codigoInterno;
        this.nombreComercial = nombreComercial;
        this.direccion = direccion;
        this.telefono = telefono;
        this.email = email;
        this.fechaApertura = fechaApertura;
        this.horaApertura = horaApertura;
        this.horaCierre = horaCierre;
        this.abierta24h = abierta24h;
        this.configuracionFacturacion = configuracionFacturacion;
    }

    public int getId() { return id; }
    public String getCodigoInterno() { return codigoInterno; }
    public String getNombreComercial() { return nombreComercial; }
    public ConfiguracionFacturacion getConfiguracionFacturacion() { return configuracionFacturacion; }
}
