package model;

public class Proveedor {
    private int id;
    private String cif;
    private String razonSocial;
    private String telefono;
    private String email;

    public Proveedor(int id, String cif, String razonSocial, String telefono, String email) {
        this.id = id;
        this.cif = cif;
        this.razonSocial = razonSocial;
        this.telefono = telefono;
        this.email = email;
    }

    public int getId() { return id; }
    public String getRazonSocial() { return razonSocial; }
}