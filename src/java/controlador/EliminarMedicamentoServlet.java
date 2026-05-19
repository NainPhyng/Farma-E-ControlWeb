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

@WebServlet("/EliminarMedicamentoServlet")
public class EliminarMedicamentoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam != null) {
            try {
                int idMedicamento = Integer.parseInt(idParam);
                Connection conn = null;
                PreparedStatement ps = null;
                
                try {
                    // 🛠️ ¡AQUÍ ESTABA EL DETALLE! Cambiado a getConexion() para que coincida con tu clase Conexion
                    conn = Conexion.getConexion();
                    
                    String sql = "DELETE FROM medicamentos WHERE id_medicamento = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, idMedicamento);
                    
                    int filasAfectadas = ps.executeUpdate();
                    
                    if (filasAfectadas > 0) {
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
            } catch (NumberFormatException e) {
                // Por seguridad, si el ID no es un número válido, regresa al panel
                response.sendRedirect("panelAdmin.jsp?status=error");
            }
        } else {
            response.sendRedirect("panelAdmin.jsp");
        }
    }
}