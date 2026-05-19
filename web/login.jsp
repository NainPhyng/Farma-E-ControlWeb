<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Iniciar sesión</title>
<link rel="stylesheet" href="css/cuenta.css">
</head>
<body>

<div class="auth-container">
  <div class="auth-card">

    <h2>Iniciar sesión</h2>

    <form action="LoginServlet" method="post">

        <input type="text" name="usuario" placeholder="Usuario" required>

        <input type="email" name="correo" placeholder="Correo" required>

        <input type="password" name="password" placeholder="Contraseña" required>

        <button type="submit">Entrar</button>

    </form>

    <a class="auth-link" href="register.jsp">¿No tienes cuenta? Crear cuenta</a>

  </div>
</div>

</body>

</html>

