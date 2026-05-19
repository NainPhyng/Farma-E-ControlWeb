<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>
<%@page import="controlador.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%
    // Validar sesión de Administrador
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"Administrador".equals(usuario.getRol())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Capturar el ID que viene de la tabla
    String idParam = request.getParameter("id");
    int idMedicamento = Integer.parseInt(idParam);

    // Variables para rellenar el formulario
    String nombre = "";
    String sustancia = "";
    double precio = 0.0;
    int stock = 0;
    int idCategoria = 1;

    // Consultar los datos actuales del medicamento
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        conn = Conexion.getConnection();
        String sql = "SELECT * FROM medicamentos WHERE id_medicamento = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, idMedicamento);
        rs = ps.executeQuery();
        if(rs.next()) {
            nombre = rs.getString("nombre_comercial");
            sustancia = rs.getString("sustancia_activa");
            precio = rs.getDouble("precio");
            stock = rs.getInt("stock");
            idCategoria = rs.getInt("id_categoria");
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception e){}
        try { if(ps != null) ps.close(); } catch(Exception e){}
        try { if(conn != null) conn.close(); } catch(Exception e){}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Medicamento - Farma E-Control</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <div class="container">
        <h1>Farma E-Control</h1>
        <h3>Modificar Medicamento (ID: <%= idMedicamento %>)</h3>
        <hr>
        
        <form action="EditarMedicamentoServlet" method="post">
            <input type="hidden" name="id" value="<%= idMedicamento %>">
            
            <label>Nombre Comercial:</label>
            <input type="text" name="nombre" value="<%= nombre %>" required>
            
            <label>Sustancia Activa:</label>
            <input type="text" name="sustancia" value="<%= sustancia %>" required>
            
            <label>Precio de Venta ($):</label>
            <input type="number" step="0.01" name="precio" value="<%= precio %>" required>
            
            <label>Cantidad en Stock:</label>
            <input type="number" name="stock" value="<%= stock %>" required>
            
            <label>Categoría:</label>
            <select name="id_categoria" required>
                <option value="1" <%= (idCategoria == 1) ? "selected" : "" %>>Analgésicos</option>
                <option value="2" <%= (idCategoria == 2) ? "selected" : "" %>>Antibióticos</option>
                <option value="3" <%= (idCategoria == 3) ? "selected" : "" %>>Vitaminas y Suplementos</option>
                <option value="4" <%= (idCategoria == 4) ? "selected" : "" %>>Antiinflamatorios</option>
            </select>
            
            <button type="submit" style="background-color: #3182ce;">Actualizar Cambios</button>
        </form>
        
        <button class="btn-logout" style="background-color: #718096;" onclick="window.location.href='panelAdmin.jsp'">Cancelar y Volver</button>
    </div>
</body>
</html>