<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"Personal de Almacén".equals(usuario.getRol())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Almacén - Farma E-Control</title>
    <link rel="stylesheet" href="css/cuenta.css">
</head>
<body>
    <div class="container">
        <h1>📦 Control de Inventario e Almacén</h1>
        <h3>Operador: <%= usuario.getNombre() %></h3>
        <hr>

        <ul>
            <li><strong>Módulo de Gestión de Inventarios:</strong> Registrar entradas y salidas de medicamentos.</li>
            <li><strong>Módulo de Consulta de Inventario:</strong> Ver stock actual y alertas de caducidad.</li>
        </ul>

        <br><br>
        <button onclick="window.location.href='CerrarSesionServlet'">Cerrar sesión</button>
    </div>
</body>
</html>