<%-- 
    Document   : estado-mora
    Created on : 11-28-2025, 12:43:05 AM
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
    <title>Estado de Mora - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
</head>
<body>
    <header>
        <div class="container">
            <h1> Estado de Mora</h1>
            <nav>
                <span><%= session.getAttribute("usuarioNombre") %></span>
                <a href="mis-prestamos.jsp">Mis Préstamos</a>
                <a href="dashboard-<%= "PROFESOR".equals(usuarioTipo) ? "profesor" : "alumno" %>.jsp">Mi Panel</a>
                <form action="../LogoutServlet" method="post" style="display: inline;">
                    <button type="submit" class="logout-btn">Cerrar Sesión</button>
                </form>
            </nav>
        </div>
    </header>

    <main class="container">
        <div style="background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h2>Consultar Mora Pendiente</h2>
            
            <div style="margin: 2rem 0; padding: 1.5rem; background: #fff3cd; border: 1px solid #ffeaa7; border-radius: 6px;">
                <h3 style="color: #856404; margin-top: 0;"> Estado Actual</h3>
                <p><strong>Mora pendiente:</strong> $0.00</p>
                <p><strong>Préstamos con retraso:</strong> 0</p>
                <p><strong>Estado:</strong> <span style="color: #27ae60; font-weight: bold;">Al día</span></p>
            </div>
            
            <div style="background: #e8f4fd; padding: 1rem; border-radius: 6px;">
                <p><strong> Información importante:</strong></p>
                <ul>
                    <li>La mora se calcula a $1.00 por día de retraso</li>
                    <li>No podrá realizar nuevos préstamos si tiene mora pendiente</li>
                    <li>El pago de mora se realiza en la biblioteca</li>
                </ul>
            </div>
        </div>
    </main>
</body>
</html>