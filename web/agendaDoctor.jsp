<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"Doctor".equals(usuario.getRol())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel Médico - Farma E-Control</title>
    <link rel="stylesheet" href="css/cuenta.css">
</head>
<body>
    <div class="container">
        <h1>Portal Médico Farma E-Control</h1>
        <h3>Dr(a). <%= usuario.getNombre() %></h3>
        <hr>

        <div class="doctor-grid">
            <div class="card">🗓️ Módulo de Agenda de Citas</div>
            <div class="card">💻 Módulo de Diagnóstico Virtual</div>
            <div class="card">📂 Módulo de Historial Clínico</div>
            <div class="card">📝 Módulo de Recetas Electrónicas</div>
        </div>

        <br><br>
        <button onclick="window.location.href='CerrarSesionServlet'">Cerrar sesión</button>
    </div>
</body>
</html>