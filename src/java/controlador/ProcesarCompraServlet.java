package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ProcesarCompraServlet", urlPatterns = {"/ProcesarCompraServlet"})
public class ProcesarCompraServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Obtener la sesión actual
        HttpSession session = request.getSession();
        
        // 🔒 FILTRO DE SEGURIDAD: Verificar si el usuario ya inició sesión
        Object usuarioLogueado = session.getAttribute("usuario");
        
        if (usuarioLogueado == null) {
            // Si NO ha iniciado sesión, lo mandamos a loguearse para mayor seguridad.
            // El carrito NO se borra, se queda guardado en la sesión para cuando regrese.
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return; // Detiene la ejecución del Servlet aquí mismo
        }
        
        // 2. Si el usuario sí está logueado, procedemos con el carrito
        ArrayList<Integer> carrito = (ArrayList<Integer>) session.getAttribute("carrito");
        
        // 3. Si el carrito existe y tiene productos, calculamos el total rápido para el ticket
        double total = 0.0;
        if (carrito != null && !carrito.isEmpty()) {
            for (int id : carrito) {
                if (id == 1) total += 115.60;
                else if (id == 2) total += 799.00;
                else if (id == 3) total += 165.00;
                else if (id == 4) total += 902.40;
                else if (id == 5) total += 1064.00;
                else total += 100.00;
            }
            
            // 4. ¡COMPRA EXITOSA! Ahora sí vaciamos el carrito de la sesión
            session.setAttribute("carrito", new ArrayList<Integer>());
            
            // 5. Mostramos la pantalla limpia de "Ticket de Compra"
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Farma E-Control - Éxito</title>");
                out.println("<link rel='stylesheet' href='css/diseño.css'>");
                out.println("<style>");
                out.println(".ticket-container { max-width: 500px; margin: 50px auto; padding: 30px; background: white; border-radius: 8px; text-align: center; box-shadow: 0px 4px 10px rgba(0,0,0,0.1); font-family: Arial; }");
                out.println(".btn-volver { background-color: #00bcd4; color: white; text-decoration: none; padding: 10px 20px; display: inline-block; margin-top: 20px; border-radius: 5px; font-weight: bold; }");
                out.println("</style>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='ticket-container'>");
                out.println("<h1 style='color: #25d366;'>✔ ¡Compra Procesada Con Éxito!</h1>");
                out.println("<p>Tu pedido en <strong>Farma E-Control</strong> ha sido verificado de forma segura.</p>");
                out.println("<hr style='border: 1px dashed #ddd;'>");
                out.println("<p style='font-size: 16px; color: #333;'>Usuario verificado: <strong>" + usuarioLogueado.toString() + "</strong></p>");
                out.println("<p style='font-size: 18px;'>Total cobrado: <strong style='color: #00bcd4;'>$" + String.format("%.2f", total) + " MXN</strong></p>");
                out.println("<p style='color: #777; font-size: 13px;'>Esta transacción ha sido registrada de forma segura.</p>");
                out.println("<a href='index.jsp' class='btn-volver'>Volver a la Tienda</a>");
                out.println("</div>");
                out.println("</body>");
                out.println("</html>");
            }
        } else {
            // Si intentan procesar un carrito vacío, los mandamos de regreso al index
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}