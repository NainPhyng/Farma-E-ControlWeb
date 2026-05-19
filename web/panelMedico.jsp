<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Usuario"%>
<%@page import="controlador.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%
    // 1. VALIDACIÓN DE SESIÓN MÉDICA (CORREGIDA: Ahora busca "Doctor")
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"Doctor".equals(usuario.getRol())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lógica para pintar los días del calendario dinámicamente
    Calendar cal = Calendar.getInstance();
    int diaHoy = cal.get(Calendar.DAY_OF_MONTH);
    int maxDias = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
    String mesActual = meses[cal.get(Calendar.MONTH)];
    int anioActual = cal.get(Calendar.YEAR);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel Médico - Farma E-Control</title>
    <link rel="stylesheet" href="css/medico.css">
</head>
<body>

    <div class="container-medico">
        
        <main>
            <div class="card">
                <h1>🩺 Sistema Clínico Farma E-Control</h1>
                <h3>Médico Adscrito: Dr(a). <%= usuario.getNombre() %></h3>
                <hr>
                
                <%
                    String status = request.getParameter("status");
                    if("success_paciente".equals(status)) {
                %>
                    <div class="alert-med">✔️ Paciente registrado correctamente en el historial clínico.</div>
                <%
                    } else if("success_receta".equals(status)) {
                %>
                    <div class="alert-med">✔️ Receta emitida con éxito. El stock de medicamentos ha sido actualizado en el almacén.</div>
                <%
                    } else if("error_stock".equals(status)) {
                %>
                    <div class="alert-med" style="background-color: #fef2f2; color: #991b1b; border-left-color: #dc2626;">❌ Error: No hay suficiente stock disponible del medicamento seleccionado.</div>
                <%
                    } else if("error".equals(status) || "db_error".equals(status)) {
                %>
                    <div class="alert-med" style="background-color: #fef2f2; color: #991b1b; border-left-color: #dc2626;">❌ Hubo un problema al procesar la solicitud. Revisa el servidor.</div>
                <%
                    }
                %>
            </div>

            <div class="card">
                <h2>📋 Registrar Consulta / Paciente Nuevo</h2>
                <form action="GuardarPacienteServlet" method="post" style="display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 15px;">
                    <div style="grid-column: span 3; margin-bottom: -10px;">
                        <label>Nombre Completo del Paciente:</label>
                        <input type="text" name="nombre_paciente" placeholder="Ej. Carlos Mendoza Flores" required>
                    </div>
                    <div>
                        <label>Edad:</label>
                        <input type="number" name="edad" placeholder="Ej. 24" required>
                    </div>
                    <div>
                        <label>Género:</label>
                        <select name="genero" required>
                            <option value="Masculino">Masculino</option>
                            <option value="Femenino">Femenino</option>
                            <option value="Otro">Otro</option>
                        </select>
                    </div>
                    <div>
                        <label>Acción:</label>
                        <button type="submit" style="padding: 10px;">Registrar Paciente</button>
                    </div>
                    <div style="grid-column: span 3;">
                        <label>Diagnóstico Inicial / Síntomas:</label>
                        <textarea name="diagnostico" rows="3" placeholder="Escribe aquí los síntomas y observaciones médicas..." required style="width: 100%; border: 1px solid #99f6e4; border-radius: 6px; padding: 10px; font-family: inherit; resize: none;"></textarea>
                    </div>
                </form>
            </div>

            <div class="card">
                <h2>✍️ Emitir Nueva Receta Digital</h2>
                <p style="font-size: 13px; color: #64748b; margin-top: -10px; margin-bottom: 15px;">
                    Selecciona el paciente y asigna el medicamento. El stock del almacén disminuirá de forma automática.
                </p>
                
                <form action="ProcesarRecetaServlet" method="post">
                    
                    <label>Seleccionar Paciente de la Lista:</label>
                    <select name="id_paciente" required>
                        <option value="">-- Selecciona un paciente registrado --</option>
                        <%
                            Connection connMed = null;
                            PreparedStatement psMed = null;
                            ResultSet rsMed = null;
                            try {
                                connMed = Conexion.getConnection();
                                // Traemos los pacientes ordenados del más reciente al más antiguo
                                String sqlPacientes = "SELECT id_paciente, nombre_completo FROM pacientes ORDER BY id_paciente DESC";
                                psMed = connMed.prepareStatement(sqlPacientes);
                                rsMed = psMed.executeQuery();
                                while(rsMed.next()) {
                        %>
                                    <option value="<%= rsMed.getInt("id_paciente") %>"><%= rsMed.getString("nombre_completo") %></option>
                        <%
                                }
                            } catch(Exception e) { 
                                e.printStackTrace(); 
                            }
                            // Mantenemos la conexión abierta para el siguiente select, cerramos solo los flujos de lectura intermedias
                            try { if(rsMed != null) rsMed.close(); } catch(Exception e){}
                            try { if(psMed != null) psMed.close(); } catch(Exception e){}
                        %>
                    </select>

                    <label>Medicamento a Recetar (Solo con Stock disponible):</label>
                    <select name="id_medicamento" required>
                        <option value="">-- Selecciona del inventario disponible --</option>
                        <%
                            try {
                                // Traemos medicamentos que tengan por lo menos 1 pieza en el inventario
                                String sqlMeds = "SELECT id_medicamento, nombre_comercial, stock FROM medicamentos WHERE stock > 0 ORDER BY nombre_comercial ASC";
                                psMed = connMed.prepareStatement(sqlMeds);
                                rsMed = psMed.executeQuery();
                                while(rsMed.next()) {
                        %>
                                    <option value="<%= rsMed.getInt("id_medicamento") %>">
                                        <%= rsMed.getString("nombre_comercial") %> (<%= rsMed.getInt("stock") %> pzas disponibles)
                                    </option>
                        <%
                                }
                            } catch(Exception e) { 
                                e.printStackTrace(); 
                            } finally {
                                // Cerramos de forma segura todas las conexiones de la página
                                try { if(rsMed != null) rsMed.close(); } catch(Exception e){}
                                try { if(psMed != null) psMed.close(); } catch(Exception e){}
                                try { if(connMed != null) connMed.close(); } catch(Exception e){}
                            }
                        %>
                    </select>

                    <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 15px;">
                        <div>
                            <label>Cantidad (Cajas):</label>
                            <input type="number" name="cantidad" value="1" min="1" required>
                        </div>
                        <div>
                            <label>Dosis e Indicaciones:</label>
                            <input type="text" name="dosis" placeholder="Ej. Tomar 1 tableta cada 8 horas por 5 días" required>
                        </div>
                    </div>

                    <button type="submit" style="background-color: #0f766e; margin-top: 10px;">Firmar y Emitir Receta</button>
                </form>
            </div>
        </main>

        <aside>
            <div class="calendar-box">
                <div class="calendar-header">
                    📅 <%= mesActual %> <%= anioActual %>
                </div>
                <div class="calendar-grid">
                    <div class="day-name">D</div><div class="day-name">L</div><div class="day-name">M</div>
                    <div class="day-name">M</div><div class="day-name">J</div><div class="day-name">V</div>
                    <div class="day-name">S</div>
                    
                    <%
                        for(int i = 1; i <= maxDias; i++) {
                            if(i == diaHoy) {
                    %>
                                <div class="day-number day-current" title="Hoy es día <%= i %>"><%= i %></div>
                    <%
                            } else {
                    %>
                                <div class="day-number" onclick="alert('Agenda médica del día <%= i %> de <%= mesActual %>: \nNo tienes citas registradas para esta fecha.')"><%= i %></div>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
            
            <div style="margin-top: 20px;">
                <button class="btn-logout-med" onclick="window.location.href='CerrarSesionServlet'">Cerrar Sesión</button>
            </div>
        </aside>

    </div>

</body>
</html>