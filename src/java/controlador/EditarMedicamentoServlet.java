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

@WebServlet("/EditarMedicamentoServlet")
public class EditarMedicamentoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int idMedicamento = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String sustancia = request.getParameter("sustancia");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = Conexion.getConexion();
            String sql = "UPDATE medicamentos SET nombre_comercial = ?, sustancia_activa = ?, precio = ?, stock = ?, id_categoria = ? WHERE id_medicamento = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, sustancia);
            ps.setDouble(3, precio);
            ps.setInt(4, stock);
            ps.setInt(5, idCategoria);
            ps.setInt(6, idMedicamento);
            
            int filasActualizadas = ps.executeUpdate();
            
            if (filasActualizadas > 0) {
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