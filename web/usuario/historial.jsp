<%-- 
    Document   : historial
    Created on : 11-28-2025, 12:42:31 AM
    Author     : josed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String usuarioTipo = (String) session.getAttribute("usuarioTipo");
    if (usuarioTipo == null || (!"ALUMNO".equals(usuarioTipo) && !"PROFESOR".equals(usuarioTipo))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Historial - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
</head>
<body>
    <header>
        <div class="container">
            <h1> Historial de Préstamos</h1>
            <nav>
                <span><%= session.getAttribute("usuarioNombre") %></span>
                <a href="mis-prestamos.jsp">Préstamos Activos</a>
                <a href="dashboard-<%= "PROFESOR".equals(usuarioTipo) ? "profesor" : "alumno" %>.jsp">Mi Panel</a>
                <form action="../LogoutServlet" method="post" style="display: inline;">
                    <button type="submit" class="logout-btn">Cerrar Sesión</button>
                </form>
            </nav>
        </div>
    </header>

    <main class="container">
        <div style="background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h2>Historial Completo</h2>
            <p>Revise su historial completo de préstamos en la biblioteca.</p>
            
            <div style="margin-top: 2rem; padding: 1rem; background: #f8f9fa; border-radius: 6px;">
                <p><strong>Funcionalidad en desarrollo</strong></p>
                <p>Este módulo mostrará:</p>
                <ul>
                    <li>Historial completo de préstamos</li>
                    <li>Estadísticas de uso</li>
                    <li>Materiales más solicitados</li>
                    <li>Exportar reportes</li>
                </ul>
            </div>
        </div>
    </main>
</body>
</html>
