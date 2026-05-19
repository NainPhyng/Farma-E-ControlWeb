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
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recuperar los parámetros que vienen desde login.jsp
        String txtUsuario = request.getParameter("usuario");
        String txtCorreo = request.getParameter("correo");
        String txtPassword = request.getParameter("password");
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // 2. Conectarse a la base de datos
conn = Conexion.getConexion();            
            // 3. Consulta SQL para verificar las tres credenciales
            String sql = "SELECT * FROM usuarios WHERE username = ? AND correo = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, txtUsuario);
            ps.setString(2, txtCorreo);
            ps.setString(3, txtPassword);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // ¡Usuario encontrado! Creamos el objeto con sus datos
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setUsername(rs.getString("username"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setRol(rs.getString("rol"));
                
                // 4. Crear la sesión del servidor y guardar al usuario
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                
                // 5. Redirección inteligente basada en tu Mapa de Navegación
                String rol = usuario.getRol();
                
                if ("Cliente".equals(rol)) {
                    response.sendRedirect("miCuenta.jsp");
                } else if ("Administrador".equals(rol)) {
                    response.sendRedirect("panelAdmin.jsp"); // O el nombre de tu archivo de reportes
                } else if ("Doctor".equals(rol)) {
                    response.sendRedirect("panelMedico.jsp"); // O tu archivo de agenda
                } else if ("Personal de Almacén".equals(rol)) {
                    response.sendRedirect("inventarioAlmacen.jsp"); // O tu archivo de inventarios
                } else {
                    response.sendRedirect("index.html"); // Por si acaso
                }
                
            } else {
                // Si los datos están mal, lo regresamos al login con un mensaje de error
                response.sendRedirect("login.jsp?error=invalid");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db");
        } finally {
            // Cerrar flujos de conexión de forma segura
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}