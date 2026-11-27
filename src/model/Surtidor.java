package model;

public class Surtidor {
    private int id;
    private String codigoEquipo;
    private int numeroVisible;
    private String tipoCombustible;
    private String estadoServicio; // OPERATIVO, MANTENIMIENTO, FUERA_DE_SERVICIO
    private Estacion estacion;

    public Surtidor(int id, String codigoEquipo, int numeroVisible, String tipoCombustible, String estadoServicio, Estacion estacion) {
        this.id = id;
        this.codigoEquipo = codigoEquipo;
        this.numeroVisible = numeroVisible;
        this.tipoCombustible = tipoCombustible;
        this.estadoServicio = estadoServicio;
        this.estacion = estacion;
    }

    public int getId() { return id; }
    public String getCodigoEquipo() { return codigoEquipo; }
    public String getEstadoServicio() { return estadoServicio; }
}
