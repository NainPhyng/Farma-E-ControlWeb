package controlador; // Revisa si tu paquete se llama controlador o controladores

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AgregarCarritoServlet", urlPatterns = {"/AgregarCarritoServlet"})
public class AgregarCarritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recuperamos el ID del producto enviado por el formulario
        String idString = request.getParameter("id_medicamento");
        
        if (idString != null && !idString.isEmpty()) {
            try {
                int idMedicamento = Integer.parseInt(idString);
                
                // 2. Accedemos a la sesión del servidor
                HttpSession session = request.getSession();
                
                // 3. Obtenemos el carrito existente o creamos uno nuevo
                ArrayList<Integer> carrito = (ArrayList<Integer>) session.getAttribute("carrito");
                if (carrito == null) {
                    carrito = new ArrayList<>();
                }
                
                // 4. Añadimos el medicamento
                carrito.add(idMedicamento);
                
                // 5. Guardamos de nuevo el estado de la lista en la sesión
                session.setAttribute("carrito", carrito);
                
            } catch (NumberFormatException e) {
                System.out.println("Error de formato en ID: " + e.getMessage());
            }
        }
        
        // 6. REDIRECCIÓN LIMPIA Y DIRECTA AL CARRITO JSP
        response.sendRedirect(request.getContextPath() + "/carrito.jsp");
    }
}