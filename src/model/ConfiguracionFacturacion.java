package model;

public class ConfiguracionFacturacion {
    private int id;
    private String codigoConfiguracion;
    private String serieTicket;
    private int siguienteNumero;
    private String textoPie;

    public ConfiguracionFacturacion(int id, String codigoConfiguracion, String serieTicket, int siguienteNumero, String textoPie) {
        this.id = id;
        this.codigoConfiguracion = codigoConfiguracion;
        this.serieTicket = serieTicket;
        this.siguienteNumero = siguienteNumero;
        this.textoPie = textoPie;
    }

    public int getId() { return id; }
    public String getCodigoConfiguracion() { return codigoConfiguracion; }
    public String getSerieTicket() { return serieTicket; }
    public int getSiguienteNumero() { return siguienteNumero; }
    public String getTextoPie() { return textoPie; }
}