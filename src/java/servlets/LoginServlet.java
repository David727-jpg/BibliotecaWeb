/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;


import service.UsuarioService;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author josed
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private UsuarioService usuarioService;
    
    @Override
    public void init() throws ServletException {
        this.usuarioService = new UsuarioService();
        System.out.println(" LoginServlet inicializado");
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            // 1. OBTENER parámetros del formulario
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String tipoUsuario = request.getParameter("tipoUsuario");
            
            System.out.println(" Intento de login: " + email + " - " + tipoUsuario);
            
            // 2. VALIDAR credenciales (aquí necesitarás un UsuarioService)
            // Por ahora simulamos la validación
            boolean loginExitoso = validarCredenciales(email, password, tipoUsuario);
            
            if (loginExitoso) {
                // 3. CREAR sesión
                HttpSession session = request.getSession();
                session.setAttribute("usuarioEmail", email);
                session.setAttribute("usuarioTipo", tipoUsuario);
                session.setAttribute("usuarioNombre", obtenerNombreUsuario(email));
                
                // 4. REDIRIGIR según tipo de usuario
                switch (tipoUsuario) {
                    case "ADMINISTRADOR":
                        response.sendRedirect("admin/dashboard.jsp");
                        break;
                    case "PROFESOR":
                        response.sendRedirect("usuario/dashboard-profesor.jsp");
                        break;
                    case "ALUMNO":
                        response.sendRedirect("usuario/dashboard-alumno.jsp");
                        break;
                    default:
                        response.sendRedirect("publico/index.html");
                }
                
                System.out.println(" Login exitoso: " + email + " redirigido a " + tipoUsuario);
                
            } else {
                // Login fallido
                mostrarErrorLogin(response, "Credenciales incorrectas. Intente nuevamente.");
            }
            
        } catch (Exception e) {
            mostrarErrorLogin(response, "Error en el sistema: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // MÉTODO TEMPORAL - luego lo integrarás con tu UsuarioService real
    private boolean validarCredenciales(String email, String password, String tipoUsuario) {
        // SIMULACIÓN - siempre retorna true para pruebas
        // Luego reemplazarás esto con tu lógica real de autenticación
        System.out.println(" Validando: " + email + " - " + password + " - " + tipoUsuario);
        
        // Credenciales de prueba
        if ("admin@udb.edu.sv".equals(email) && "1234".equals(password) && "ADMINISTRADOR".equals(tipoUsuario)) {
            return true;
        }
        if ("profesor@udb.edu.sv".equals(email) && "1234".equals(password) && "PROFESOR".equals(tipoUsuario)) {
            return true;
        }
        if ("alumno@udb.edu.sv".equals(email) && "1234".equals(password) && "ALUMNO".equals(tipoUsuario)) {
            return true;
        }
        
        return true; // Temporalmente siempre true para pruebas
    }
    
    private String obtenerNombreUsuario(String email) {
        // SIMULACIÓN - luego con tu base de datos real
        switch (email) {
            case "admin@udb.edu.sv": return "Administrador Principal";
            case "profesor@udb.edu.sv": return "Profesor Carlos";
            case "alumno@udb.edu.sv": return "Alumna Ana García";
            default: return "Usuario";
        }
    }
    
    private void mostrarErrorLogin(HttpServletResponse response, String mensaje) throws IOException {
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Error de Login</title>");
        out.println("<link rel=\"stylesheet\" href=\"css/estilos.css\">");
        out.println("</head>");
        out.println("<body>");
        out.println("<header><div class=\"container\"><h1> Biblioteca UDB</h1></div></header>");
        out.println("<main class=\"container\">");
        out.println("<div class=\"error-login\">");
        out.println("<h2> Error de Autenticación</h2>");
        out.println("<p>" + mensaje + "</p>");
        out.println("<a href=\"login.jsp\" class=\"btn-nueva-busqueda\">Volver al Login</a>");
        out.println("</div>");
        out.println("</main>");
        out.println("</body>");
        out.println("</html>");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    }

  


