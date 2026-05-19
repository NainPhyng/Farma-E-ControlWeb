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
import modelo.Paciente;

@WebServlet("/GuardarPacienteServlet")
public class GuardarPacienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recuperar parámetros del formulario clínico
        String nombre = request.getParameter("nombre_paciente");
        int edad = Integer.parseInt(request.getParameter("edad"));
        String genero = request.getParameter("genero");
        String diagnostico = request.getParameter("diagnostico");
        
        // 2. Mapear al modelo Paciente
        Paciente paciente = new Paciente();
        paciente.setNombreCompleto(nombre);
        paciente.setEdad(edad);
        paciente.setGenero(genero);
        paciente.setDiagnostico(diagnostico);
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
conn = Conexion.getConexion();            
            // 3. Insertar en la BD
            String sql = "INSERT INTO pacientes (nombre_completo, edad, genero, diagnostico) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, paciente.getNombreCompleto());
            ps.setInt(2, paciente.getEdad());
            ps.setString(3, paciente.getGenero());
            ps.setString(4, paciente.getDiagnostico());
            
            int resultado = ps.executeUpdate();
            
            if (resultado > 0) {
                // Al tener éxito, recarga el panel indicando éxito de paciente
                response.sendRedirect("panelMedico.jsp?status=success_paciente");
            } else {
                response.sendRedirect("panelMedico.jsp?status=error");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("panelMedico.jsp?status=db_error");
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}