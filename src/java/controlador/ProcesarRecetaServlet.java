package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ProcesarRecetaServlet")
public class ProcesarRecetaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recuperar los datos del formulario de la e-receta
        int idPaciente = Integer.parseInt(request.getParameter("id_paciente"));
        int idMedicamento = Integer.parseInt(request.getParameter("id_medicamento"));
        int cantidadRecetada = Integer.parseInt(request.getParameter("cantidad"));
        String dosis = request.getParameter("dosis");
        
        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psInsert = null;
        PreparedStatement psUpdate = null;
        ResultSet rs = null;
        
        try {
conn = Conexion.getConexion();            // Desactivamos el autocommit para manejarlo como una transacción segura
            conn.setAutoCommit(false);
            
            // TAREA 1: Validar si hay stock suficiente en el almacén
            String sqlCheck = "SELECT stock FROM medicamentos WHERE id_medicamento = ?";
            psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setInt(1, idMedicamento);
            rs = psCheck.executeQuery();
            
            if (rs.next()) {
                int stockActual = rs.getInt("stock");
                
                if (stockActual < cantidadRecetada) {
                    // Si el médico pide más de lo que hay, cancelamos y mandamos alerta
                    conn.rollback();
                    response.sendRedirect("panelMedico.jsp?status=error_stock");
                    return;
                }
                
                // TAREA 2: Insertar el registro de la nueva receta
                String sqlInsert = "INSERT INTO recetas (id_paciente, id_medicamento, dosis, cantidad_recetada) VALUES (?, ?, ?, ?)";
                psInsert = conn.prepareStatement(sqlInsert);
                psInsert.setInt(1, idPaciente);
                psInsert.setInt(2, idMedicamento);
                psInsert.setString(3, dosis);
                psInsert.setInt(4, cantidadRecetada);
                psInsert.executeUpdate();
                
                // TAREA 3: Restar de forma matemática el stock del medicamento
                String sqlUpdate = "UPDATE medicamentos SET stock = stock - ? WHERE id_medicamento = ?";
                psUpdate = conn.prepareStatement(sqlUpdate);
                psUpdate.setInt(1, cantidadRecetada);
                psUpdate.setInt(2, idMedicamento);
                psUpdate.executeUpdate();
                
                // Si todo salió bien, guardamos los cambios de forma definitiva
                conn.commit();
                response.sendRedirect("panelMedico.jsp?status=success_receta");
                
            } else {
                conn.rollback();
                response.sendRedirect("panelMedico.jsp?status=error");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) {}
            response.sendRedirect("panelMedico.jsp?status=db_error");
        } finally {
            // Cierre seguro de flujos en orden inverso
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (psCheck != null) psCheck.close(); } catch (SQLException e) {}
            try { if (psInsert != null) psInsert.close(); } catch (SQLException e) {}
            try { if (psUpdate != null) psUpdate.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}