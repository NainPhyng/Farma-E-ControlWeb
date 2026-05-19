<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Cuenta - Farma E-Control</title>
    <link rel="stylesheet" href="css/cuenta.css">
</head>
<body>

<div class="auth-container">
  <div class="auth-card">

    <h2>Crear Cuenta</h2>

    <form action="RegisterServlet" method="post">
        
        <input type="text" name="nombre" placeholder="Nombre Completo" required>

        <input type="text" name="username" placeholder="Nombre de Usuario" required>

        <input type="email" name="correo" placeholder="Correo Electrónico" required>

        <input type="password" name="password" placeholder="Contraseña" required>
        
        <input type="hidden" name="rol" value="Cliente">

        <button type="submit">Registrarse</button>

    </form>

    <a class="auth-link" href="login.jsp">¿Ya tienes cuenta? Iniciar sesión</a>

  </div>
</div>

</body>
</html>