package modelo;

public class Medicamento {
    private int idMedicamento;
    private String nombreComercial;
    private String sustanciaActiva;
    private double precio;
    private int stock; // <--- NUEVO ATRIBUTO
    private int idCategoria;

    // Constructor vacío
    public Medicamento() {
    }

    // Constructor lleno actualizado
    public Medicamento(int idMedicamento, String nombreComercial, String sustanciaActiva, double precio, int stock, int idCategoria) {
        this.idMedicamento = idMedicamento;
        this.nombreComercial = nombreComercial;
        this.sustanciaActiva = sustanciaActiva;
        this.precio = precio;
        this.stock = stock;
        this.idCategoria = idCategoria;
    }

    // Getters y Setters
    public int getIdMedicamento() { return idMedicamento; }
    public void setIdMedicamento(int idMedicamento) { this.idMedicamento = idMedicamento; }

    public String getNombreComercial() { return nombreComercial; }
    public void setNombreComercial(String nombreComercial) { this.nombreComercial = nombreComercial; }

    public String getSustanciaActiva() { return sustanciaActiva; }
    public void setSustanciaActiva(String sustanciaActiva) { this.sustanciaActiva = sustanciaActiva; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getStock() { return stock; } // <--- NUEVO GETTER
    public void setStock(int stock) { this.stock = stock; } // <--- NUEVO SETTER

    public int getIdCategoria() { return idCategoria; }
    public void setIdCategoria(int idCategoria) { this.idCategoria = idCategoria; }
}