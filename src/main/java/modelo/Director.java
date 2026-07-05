package modelo;

public class Director {

    private int idDirector;
    private String nombre;
    private String apellido;
    private String pais;

    public Director() {
    }

    public Director(int idDirector, String nombre, String apellido, String pais) {
        this.idDirector = idDirector;
        this.nombre = nombre;
        this.apellido = apellido;
        this.pais = pais;
    }

    public int getIdDirector() {
        return idDirector;
    }

    public void setIdDirector(int idDirector) {
        this.idDirector = idDirector;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }
}
