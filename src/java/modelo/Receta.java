package modelo;

import java.sql.Timestamp;

public class Receta {
    private int idReceta;
    private int idPaciente;
    private int idMedicamento;
    private String dosis;
    private int cantidadRecetada;
    private Timestamp fechaEmision;

    // Constructor vacío
    public Receta() {
    }

    // Constructor lleno
    public Receta(int idReceta, int idPaciente, int idMedicamento, String dosis, int cantidadRecetada, Timestamp fechaEmision) {
        this.idReceta = idReceta;
        this.idPaciente = idPaciente;
        this.idMedicamento = idMedicamento;
        this.dosis = dosis;
        this.cantidadRecetada = cantidadRecetada;
        this.fechaEmision = fechaEmision;
    }

    // Getters y Setters
    public int getIdReceta() { return idReceta; }
    public void setIdReceta(int idReceta) { this.idReceta = idReceta; }

    public int getIdPaciente() { return idPaciente; }
    public void setIdPaciente(int idPaciente) { this.idPaciente = idPaciente; }

    public int getIdMedicamento() { return idMedicamento; }
    public void setIdMedicamento(int idMedicamento) { this.idMedicamento = idMedicamento; }

    public String getDosis() { return dosis; }
    public void setDosis(String dosis) { this.dosis = dosis; }

    public int getCantidadRecetada() { return cantidadRecetada; }
    public void setCantidadRecetada(int cantidadRecetada) { this.cantidadRecetada = cantidadRecetada; }

    public Timestamp getFechaEmision() { return fechaEmision; }
    public void setFechaEmision(Timestamp fechaEmision) { this.fechaEmision = fechaEmision; }
}