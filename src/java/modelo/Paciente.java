package modelo;

import java.sql.Timestamp;

public class Paciente {
    private int idPaciente;
    private String nombreCompleto;
    private int edad;
    private String genero;
    private String diagnostico;
    private Timestamp fechaRegistro;

    // Constructor vacío
    public Paciente() {
    }

    // Constructor lleno
    public Paciente(int idPaciente, String nombreCompleto, int edad, String genero, String diagnostico, Timestamp fechaRegistro) {
        this.idPaciente = idPaciente;
        this.nombreCompleto = nombreCompleto;
        this.edad = edad;
        this.genero = genero;
        this.diagnostico = diagnostico;
        this.fechaRegistro = fechaRegistro;
    }

    // Getters y Setters
    public int getIdPaciente() { return idPaciente; }
    public void setIdPaciente(int idPaciente) { this.idPaciente = idPaciente; }

    public String getNombreCompleto() { return nombreCompleto; }
    public void setNombreCompleto(String nombreCompleto) { this.nombreCompleto = nombreCompleto; }

    public int getEdad() { return edad; }
    public void setEdad(int edad) { this.edad = edad; }

    public String getGenero() { return genero; }
    public void setGenero(String genero) { this.genero = genero; }

    public String getDiagnostico() { return diagnostico; }
    public void setDiagnostico(String diagnostico) { this.diagnostico = diagnostico; }

    public Timestamp getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(Timestamp fechaRegistro) { this.fechaRegistro = fechaRegistro; }
}