<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%
    // 1. Recuperamos el carrito guardado por el Servlet en la sesión
    ArrayList<Integer> carrito = (ArrayList<Integer>) session.getAttribute("carrito");
    
    if (carrito == null) {
        carrito = new ArrayList<Integer>();
    }
    
    double totalAcumulado = 0.0;
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mi Carrito - Farma E-Control</title>
        <link rel="stylesheet" href="css/diseño.css">
        <style>
            .carrito-container { max-width: 1000px; margin: 30px auto; padding: 20px; background-color: white; font-family: Arial, sans-serif; }
            .tabla-carrito { width: 100%; border-collapse: collapse; margin-top: 20px; }
            .tabla-carrito th { background-color: #00bcd4; color: white; padding: 12px; text-align: left; }
            .tabla-carrito td { padding: 15px; border-bottom: 1px solid #ddd; }
            .total-seccion { text-align: right; margin-top: 20px; font-size: 18px; font-weight: bold; }
            .btn-comprar { background-color: #25d366; color: white; border: none; padding: 12px 25px; font-size: 16px; cursor: pointer; border-radius: 5px; font-weight: bold; float: right; margin-top: 15px; }
            .btn-comprar:hover { background-color: #1ebe57; }
            .btn-regresar { background-color: #00bcd4; color: white; text-decoration: none; padding: 10px 20px; display: inline-block; margin-top: 15px; border-radius: 5px; }
            .carrito-vacio { text-align: center; padding: 40px; font-size: 18px; color: #666; }
        </style>
    </head>
    <body>
        <div class="header">
            <a href="index.jsp" class="logo">
                <img src="img/logo.png" alt="Farma E-Control" style="width: 60px; height: 60px;">
                <div>
                    <div>FARMA</div>
                    <div style="font-size: 10px;">E-CONTROL</div>
                </div>
            </a>
            <div class="header-icons" style="margin-left: auto;">
                <a href="index.jsp" class="icon-item">
                    Volver a la Tienda
                </a>
            </div>
        </div>

        <div class="carrito-container">
            <h2>🛒 Tu Carrito de Compras</h2>
            
            <% if (carrito.isEmpty()) { %>
                <div class="carrito-vacio">
                    <p>Tu carrito está vacío actualmente.</p>
                    <a href="index.jsp" class="btn-regresar">Explorar Medicamentos</a>
                </div>
            <% } else { %>
                <table class="tabla-carrito">
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Precio Unitario</th>
                            <th>Cantidad</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int id : carrito) {
                                String nombreProducto = "";
                                double precio = 0.0;

                                // Mapeo de los IDs de index.jsp
                                if (id == 1) {
                                    nombreProducto = "Mi-Prim 24 cápsulas";
                                    precio = 115.60;
                                } else if (id == 2) {
                                    nombreProducto = "Perfume Ariana Grande Sweet Like Candy";
                                    precio = 799.00;
                                } else if (id == 3) {
                                    nombreProducto = "The Ordinary Salicylic Acid 2% Solution";
                                    precio = 165.00;
                                } else if (id == 4) {
                                    nombreProducto = "Omron Nebulizador de Compresor Ne-C101";
                                    precio = 902.40;
                                } else if (id == 5) {
                                    nombreProducto = "Falcon Performance Proteina Vegetal";
                                    precio = 1064.00;
                                } else {
                                    nombreProducto = "Producto General";
                                    precio = 100.00;
                                }

                                totalAcumulado += precio;
                        %>
                        <tr>
                            <td><strong><%= nombreProducto %></strong></td>
                            <td>$<%= String.format("%.2f", precio) %></td>
                            <td>1</td>
                            <td>$<%= String.format("%.2f", precio) %></td>
                        </tr>
                        <% 
                            } 
                        %>
                    </tbody>
                </table>

                <div class="total-seccion">
                    Total a Pagar: <span style="color: #00bcd4; font-size: 24px;">$<%= String.format("%.2f", totalAcumulado) %></span>
                </div>

                <a href="index.jsp" class="btn-regresar">⬅ Seguir Comprando</a>
                
                <form action="ProcesarCompraServlet" method="POST">
                    <button type="submit" class="btn-comprar">Confirmar Compra ✔</button>
                </form>
            <% } %>
        </div>
    </body>
</html>