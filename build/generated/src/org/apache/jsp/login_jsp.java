package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<html lang=\"es\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Login - Biblioteca UDB</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/estilos.css\">\n");
      out.write("    <style>\n");
      out.write("        .login-container {\n");
      out.write("            max-width: 400px;\n");
      out.write("            margin: 4rem auto;\n");
      out.write("            padding: 2rem;\n");
      out.write("            background: white;\n");
      out.write("            border-radius: 10px;\n");
      out.write("            box-shadow: 0 4px 15px rgba(0,0,0,0.1);\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .login-container h2 {\n");
      out.write("            text-align: center;\n");
      out.write("            color: #2c3e50;\n");
      out.write("            margin-bottom: 2rem;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .form-group {\n");
      out.write("            margin-bottom: 1.5rem;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .form-group label {\n");
      out.write("            display: block;\n");
      out.write("            margin-bottom: 0.5rem;\n");
      out.write("            color: #2c3e50;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .form-group input,\n");
      out.write("        .form-group select {\n");
      out.write("            width: 100%;\n");
      out.write("            padding: 12px;\n");
      out.write("            border: 2px solid #bdc3c7;\n");
      out.write("            border-radius: 6px;\n");
      out.write("            font-size: 1rem;\n");
      out.write("            transition: border-color 0.3s;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .form-group input:focus,\n");
      out.write("        .form-group select:focus {\n");
      out.write("            outline: none;\n");
      out.write("            border-color: #3498db;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .btn-login {\n");
      out.write("            width: 100%;\n");
      out.write("            padding: 12px;\n");
      out.write("            background: #27ae60;\n");
      out.write("            color: white;\n");
      out.write("            border: none;\n");
      out.write("            border-radius: 6px;\n");
      out.write("            font-size: 1.1rem;\n");
      out.write("            cursor: pointer;\n");
      out.write("            transition: background-color 0.3s;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .btn-login:hover {\n");
      out.write("            background: #219a52;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .back-link {\n");
      out.write("            text-align: center;\n");
      out.write("            margin-top: 1.5rem;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .back-link a {\n");
      out.write("            color: #3498db;\n");
      out.write("            text-decoration: none;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .back-link a:hover {\n");
      out.write("            text-decoration: underline;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <header>\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <h1> Biblioteca Universidad Don Bosco</h1>\n");
      out.write("            <nav>\n");
      out.write("                <a href=\"publico/index.html\">Catálogo Público</a>\n");
      out.write("            </nav>\n");
      out.write("        </div>\n");
      out.write("    </header>\n");
      out.write("\n");
      out.write("    <main class=\"container\">\n");
      out.write("        <div class=\"login-container\">\n");
      out.write("            <h2> Ingresar al Sistema</h2>\n");
      out.write("            \n");
      out.write("            <form action=\"LoginServlet\" method=\"POST\">\n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"email\">Email:</label>\n");
      out.write("                    <input type=\"email\" id=\"email\" name=\"email\" placeholder=\"usuario@udb.edu\" required>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"password\">Contraseña:</label>\n");
      out.write("                    <input type=\"password\" id=\"password\" name=\"password\" placeholder=\"Ingrese su contraseña\" required>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"tipoUsuario\">Tipo de Usuario:</label>\n");
      out.write("                    <select id=\"tipoUsuario\" name=\"tipoUsuario\" required>\n");
      out.write("                        <option value=\"\">Seleccionar...</option>\n");
      out.write("                        <option value=\"ALUMNO\">Alumno</option>\n");
      out.write("                        <option value=\"PROFESOR\">Profesor</option>\n");
      out.write("                        <option value=\"ADMINISTRADOR\">Administrador</option>\n");
      out.write("                    </select>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <button type=\"submit\" class=\"btn-login\">Ingresar al Sistema</button>\n");
      out.write("            </form>\n");
      out.write("            \n");
      out.write("            <div class=\"back-link\">\n");
      out.write("                <a href=\"publico/index.html\">← Volver al catálogo público</a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </main>\n");
      out.write("\n");
      out.write("    <footer>\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <p>&copy; 2024 Biblioteca Universidad Don Bosco. Todos los derechos reservados.</p>\n");
      out.write("        </div>\n");
      out.write("    </footer>\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
