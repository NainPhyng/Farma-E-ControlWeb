package controlador;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Medicamento;

@WebServlet("/GuardarMedicamentoServlet")
public class GuardarMedicamentoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recuperar los parámetros (Agregamos el stock)
        String nomComercial = request.getParameter("nombre");
        String susActiva = request.getParameter("sustancia");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock")); // <--- NUEVO
        int idCat = Integer.parseInt(request.getParameter("id_categoria"));
        
        // 2. Guardar en el modelo
        Medicamento med = new Medicamento();
        med.setNombreComercial(nomComercial);
        med.setSustanciaActiva(susActiva);
        med.setPrecio(precio);
        med.setStock(stock); // <--- NUEVO
        med.setIdCategoria(idCat);
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
conn = Conexion.getConexion();            
            // 3. SQL actualizado con la columna stock
            String sql = "INSERT INTO medicamentos (nombre_comercial, sustancia_activa, precio, stock, id_categoria) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, med.getNombreComercial());
            ps.setString(2, med.getSustanciaActiva());
            ps.setDouble(3, med.getPrecio());
            ps.setInt(4, med.getStock()); // <--- NUEVO
            ps.setInt(5, med.getIdCategoria());
            
            int resultado = ps.executeUpdate();
            
            if (resultado > 0) {
                response.sendRedirect("panelAdmin.jsp?status=success");
            } else {
                response.sendRedirect("panelAdmin.jsp?status=error");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("panelAdmin.jsp?status=db_error");
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}