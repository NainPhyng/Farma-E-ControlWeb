<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>
<%@page import="controlador.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%
    // 1. VALIDACIÓN DE SESIÓN
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"Administrador".equals(usuario.getRol())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel Administrativo - Farma E-Control</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <div class="container" style="max-width: 900px;">
        <h1>Farma E-Control</h1>
        <h3>Panel Administrativo: <%= usuario.getNombre() %></h3>
        <hr>
        
        <%
            String status = request.getParameter("status");
            if("success".equals(status)) {
        %>
            <div class="alert alert-success">¡Acción ejecutada con éxito en el inventario!</div>
        <%
            } else if("error".equals(status) || "db_error".equals(status)) {
        %>
            <div class="alert alert-error">Hubo un problema al procesar la solicitud. Revisa el servidor.</div>
        <%
            }
        %>
        
        <section class="modulos-admin" style="background: #f8fafc; padding: 20px; border-radius: 8px; border: 1px solid #e2e8f0; margin-bottom: 30px;">
            <h2>📦 Registrar Nuevo Medicamento</h2>
            
            <form action="GuardarMedicamentoServlet" method="post" style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                <div>
                    <label>Nombre Comercial:</label>
                    <input type="text" name="nombre" placeholder="Ej. Paracetamol" required style="margin-bottom: 0;">
                </div>
                <div>
                    <label>Sustancia Activa:</label>
                    <input type="text" name="sustancia" placeholder="Ej. Acetaminofén" required style="margin-bottom: 0;">
                </div>
                <div>
                    <label>Precio de Venta ($):</label>
                    <input type="number" step="0.01" name="precio" placeholder="0.00" required style="margin-bottom: 0;">
                </div>
                <div>
                    <label>Cantidad en Stock:</label>
                    <input type="number" name="stock" placeholder="Ej. 100" required style="margin-bottom: 0;">
                </div>
                <div style="grid-column: span 2;">
                    <label>Categoría del Medicamento:</label>
                    <select name="id_categoria" required style="margin-bottom: 15px;">
                        <option value="1">Analgésicos</option>
                        <option value="2">Antibióticos</option>
                        <option value="3">Vitaminas y Suplementos</option>
                        <option value="4">Antiinflamatorios</option>
                    </select>
                    <button type="submit">Guardar Medicamento</button>
                </div>
            </form>
        </section>

        <section class="seccion-reportes" style="background: #ffffff; padding: 20px; border-radius: 8px; border: 1px solid #e2e8f0; margin-bottom: 30px;">
            <h2>📊 Generación de Reportes del Sistema</h2>
            <p style="font-size: 13px; color: #718096; margin-top: -10px; margin-bottom: 15px;">
                Selecciona un criterio para filtrar el inventario y analizar el estado actual de la farmacia.
            </p>
            <div style="display: flex; gap: 10px;">
                <a href="panelAdmin.jsp" class="btn-reporte btn-rep-todos">📋 Ver Todo el Inventario</a>
                <a href="panelAdmin.jsp?reporte=stock_bajo" class="btn-reporte btn-rep-alerta">⚠️ Alerta Stock Bajo (&lt; 20 pzas)</a>
                <a href="panelAdmin.jsp?reporte=premium" class="btn-reporte btn-rep-premium">💰 Productos Premium (&gt; $100)</a>
            </div>
        </section>

        <section class="tabla-inventario">
            <%
                String tipoReporte = request.getParameter("reporte");
                String tituloTabla = "Inventario Actual de Medicamentos";
                
                if("stock_bajo".equals(tipoReporte)) {
                    tituloTabla = "⚠️ REPORTE: Medicamentos con Críticos de Stock Bajo";
                } else if("premium".equals(tipoReporte)) {
                    tituloTabla = "💰 REPORTE: Medicamentos de Alta Gama / Premium";
                }
            %>
            <h2><%= tituloTabla %></h2>
            <div style="overflow-x: auto;">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Sustancia Activa</th>
                            <th>Precio</th>
                            <th>Stock</th>
                            <th>Categoría</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            try {
                                conn = Conexion.getConnection();
                                
                                // Base de la consulta
                                String sql = "SELECT m.id_medicamento, m.nombre_comercial, m.sustancia_activa, m.precio, m.stock, c.nombre_categoria " +
                                             "FROM medicamentos m " +
                                             "LEFT JOIN categorias c ON m.id_categoria = c.id_categoria ";
                                
                                // Filtrado condicional según el reporte seleccionado
                                if("stock_bajo".equals(tipoReporte)) {
                                    sql += "WHERE m.stock < 20 ";
                                } else if("premium".equals(tipoReporte)) {
                                    sql += "WHERE m.precio > 100.00 ";
                                }
                                
                                sql += "ORDER BY m.id_medicamento DESC";
                                
                                ps = conn.prepareStatement(sql);
                                rs = ps.executeQuery();
                                
                                boolean tieneDatos = false;
                                while(rs.next()) {
                                    tieneDatos = true;
                                    int id = rs.getInt("id_medicamento");
                        %>
                                    <tr>
                                        <td><%= id %></td>
                                        <td><strong><%= rs.getString("nombre_comercial") %></strong></td>
                                        <td><%= rs.getString("sustancia_activa") %></td>
                                        <td>$<%= String.format("%.2f", rs.getDouble("precio")) %></td>
                                        <td>
                                            <span class="badge <%= (rs.getInt("stock") < 20) ? "badge-low" : "badge-ok" %>">
                                                <%= rs.getInt("stock") %> pzas
                                            </span>
                                        </td>
                                        <td><%= rs.getString("nombre_categoria") != null ? rs.getString("nombre_categoria") : "Sin Categoría" %></td>
                                        <td class="action-buttons">
                                            <a href="editarMedicamento.jsp?id=<%= id %>" class="btn-action btn-edit">Editar</a>
                                            <a href="EliminarMedicamentoServlet?id=<%= id %>" class="btn-action btn-delete" onclick="return confirm('¿Seguro que deseas eliminar este medicamento?')">Eliminar</a>
                                        </td>
                                    </tr>
                        <%
                                }
                                if(!tieneDatos) {
                        %>
                                    <tr>
                                        <td colspan="7" style="text-align: center; color: #a0aec0; padding: 20px;">No se encontraron registros para este filtro de reporte.</td>
                                    </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                try { if(rs != null) rs.close(); } catch(Exception e){}
                                try { if(ps != null) ps.close(); } catch(Exception e){}
                                try { if(conn != null) conn.close(); } catch(Exception e){}
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </section>

        <button class="btn-logout" onclick="window.location.href='CerrarSesionServlet'">Cerrar sesión</button>
    </div>
</body>
</html>