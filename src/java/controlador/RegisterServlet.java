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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recuperar los datos que vienen desde el formulario de register.jsp
        String txtNombre = request.getParameter("nombre");
        String txtUsername = request.getParameter("username");
        String txtCorreo = request.getParameter("correo");
        String txtPassword = request.getParameter("password");
        String txtRol = request.getParameter("rol"); // Viene como 'Cliente' por defecto
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            // 2. Conectarse a la base de datos
conn = Conexion.getConexion();            
            // 3. Sentencia SQL para insertar el nuevo usuario
            String sql = "INSERT INTO usuarios (nombre, username, correo, password, rol) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, txtNombre);
            ps.setString(2, txtUsername);
            ps.setString(3, txtCorreo);
            ps.setString(4, txtPassword); // En un sistema real aquí se encriptaría, pero para la escuela así directo está perfecto
            ps.setString(5, txtRol);
            
            // 4. Ejecutar la inserción
            int filasInsertadas = ps.executeUpdate();
            
            if (filasInsertadas > 0) {
                // Si se guardó con éxito, lo mandamos al login para que estrene su cuenta
                response.sendRedirect("login.jsp?registro=success");
            } else {
                response.sendRedirect("register.jsp?error=failed");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Si el correo o usuario ya existen, saltará un error aquí por las restricciones UNIQUE de la BD
            response.sendRedirect("register.jsp?error=duplicate");
        } finally {
            // Cerrar recursos
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}
