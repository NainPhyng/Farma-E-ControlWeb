<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>



<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<section class="miCuenta">

    <h1>Mi cuenta</h1>

    <div class="perfil-info">

        <div class="foto">
            <img src="img/default-user.png" id="fotoPerfil">
            <input type="file" id="inputFoto">
        </div>

        <div class="datos">
            <p><strong>Nombre:</strong> <%= usuario.getNombre() %></p>
            <p><strong>Correo:</strong> <%= usuario.getCorreo() %></p>
            <p><strong>Usuario:</strong> <%= usuario.getUsername() %></p>
        </div>

    </div>

    <div class="acciones">
        <button onclick="editarPerfil()">Editar perfil</button>
        <button onclick="cambiarPassword()">Cambiar contraseña</button>
        <button onclick="verHistorial()">Ver historial</button>
        <button class="peligro" onclick="eliminarCuenta()">Eliminar cuenta</button>
        <button onclick="cerrarSesion()">Cerrar sesión</button>
    </div>

</section>

<script>
function cerrarSesion(){
    window.location.href = "CerrarSesionServlet";
}
</script>
