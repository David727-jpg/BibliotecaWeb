/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import service.EjemplarService;
import Model.Ejemplar;

/**
 *
 * @author josed
 */
@WebServlet(name = "BuscarServlet", urlPatterns = {"/BuscarServlet"})
public class BuscarServlet extends HttpServlet {
    private EjemplarService ejemplarService;
    
    @Override
    public void init() throws ServletException{
        this.ejemplarService = new EjemplarService();
        System.out.println("BuscarServlet inicializado con EjemplarService");
    }
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       try {
            // 1. OBTENER el parámetro de búsqueda del formulario HTML
            String termino = request.getParameter("termino");
            System.out.println("🔍 Búsqueda recibida: " + termino);
            
            // 2. USAR tu servicio actual para buscar
            List<Ejemplar> resultados = ejemplarService.buscarEjemplarPorTitulo(termino);
            System.out.println(" Resultados encontrados: " + resultados.size());
            
            // 3. PREPARAR respuesta HTML
            PrintWriter out = response.getWriter();
            
            // 4. CONSTRUIR HTML con los resultados
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Resultados de Búsqueda</title>");
            out.println("<link rel=\"stylesheet\" href=\"css/estilos.css\">");
            out.println("</head>");
            out.println("<body>");
            
            // Header
            out.println("<header>");
            out.println("<div class=\"container\">");
            out.println("<h1> Biblioteca Universidad Don Bosco</h1>");
            out.println("<nav>");
            out.println("<a href=\"publico/index.html\">Inicio</a>");
            out.println("<a href=\"publico/buscar.html\">Nueva Búsqueda</a>");
            out.println("</nav>");
            out.println("</div>");
            out.println("</header>");
            
            // Contenido principal
            out.println("<main class=\"container\">");
            out.println("<div class=\"resultados-busqueda\">");
            out.println("<h2> Resultados de Búsqueda</h2>");
            out.println("<p>Término buscado: <strong>" + termino + "</strong></p>");
            
            if (resultados.isEmpty()) {
                out.println("<div class=\"no-resultados\">");
                out.println("<h3>No se encontraron ejemplares</h3>");
                out.println("<p>Intente con otros términos de búsqueda.</p>");
                out.println("</div>");
            } else {
                out.println("<div class=\"resultados-lista\">");
                out.println("<p>Se encontraron <strong>" + resultados.size() + "</strong> ejemplares:</p>");
                
                for (Ejemplar ejemplar : resultados) {
                    out.println("<div class=\"ejemplar-card\">");
                    out.println("<h3>" + ejemplar.getTitulo() + "</h3>");
                    out.println("<div class=\"ejemplar-info\">");
                    
                    if (ejemplar.getAutor() != null && !ejemplar.getAutor().isEmpty()) {
                        out.println("<div class=\"info-item\"><strong>Autor:</strong> " + ejemplar.getAutor() + "</div>");
                    }
                    
                    out.println("<div class=\"info-item\"><strong>Tipo:</strong> " + ejemplar.getTipo() + "</div>");
                    out.println("<div class=\"info-item\"><strong>Ubicación:</strong> " + ejemplar.getUbicacion() + "</div>");
                    
                    String disponibilidad = ejemplar.getCantidadDisponible() > 0 ? 
                        "<span class=\"disponible\">" + ejemplar.getCantidadDisponible() + " disponibles</span>" : 
                        "<span class=\"no-disponible\">Agotado</span>";
                    
                    out.println("<div class=\"info-item\"><strong>Disponibilidad:</strong> " + disponibilidad + "</div>");
                    
                    out.println("</div>"); // cierre ejemplar-info
                    out.println("</div>"); // cierre ejemplar-card
                }
                
                out.println("</div>"); // cierre resultados-lista
            }
            
            out.println("</div>"); // cierre resultados-busqueda
            out.println("</main>");
            
            // Footer
            out.println("<footer>");
            out.println("<div class=\"container\">");
            out.println("<p>&copy; 2024 Biblioteca Universidad Don Bosco</p>");
            out.println("</div>");
            out.println("</footer>");
            
            out.println("</body>");
            out.println("</html>");
            
        } catch (Exception e) {
            // Manejo de errores
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h2>Error en la búsqueda</h2>");
            out.println("<p>Ocurrió un error: " + e.getMessage() + "</p>");
            out.println("<a href=\"publico/index.html\">Volver al inicio</a>");
            out.println("</body></html>");
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
