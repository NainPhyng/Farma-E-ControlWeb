package modelo;

public class Usuario {

    // 1. Atributos privados (Variables para guardar los datos)
    private int idUsuario;
    private String nombre;
    private String correo;
    private String username;
    private String rol;

    // 2. Constructor vacío (Obligatorio para Java Beans)
    public Usuario() {
    }

    // 3. Constructor lleno
    public Usuario(int idUsuario, String nombre, String correo, String username, String rol) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.correo = correo;
        this.username = username;
        this.rol = rol;
    }

    // 4. Métodos Getters y Setters (Modificados sin excepciones)
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
}