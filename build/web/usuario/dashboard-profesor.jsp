<%-- 
    Document   : dashboard-profesor
    Created on : 11-27-2025, 08:08:50 PM
    Author     : josed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String usuarioTipo = (String) session.getAttribute("usuarioTipo");
    if (usuarioTipo == null || !"PROFESOR".equals(usuarioTipo)) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Panel del Profesor - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <style>
        .privilege-badge {
            background: #9b59b6;
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            margin-left: 1rem;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1> Panel del Profesor <span class="privilege-badge">6 préstamos simultáneos</span></h1>
            <nav>
                <span>Bienvenido, <%= session.getAttribute("usuarioNombre") %></span>
                <a href="../publico/index.html">Catálogo Público</a>
                <form action="../LogoutServlet" method="post" style="display: inline;">
                    <button type="submit" class="logout-btn">Cerrar Sesión</button>
                </form>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="dashboard">
            <div class="welcome-banner" style="background: linear-gradient(135deg, #8e44ad, #9b59b6);">
                <h2>Bienvenido Profesor</h2>
                <p>Como profesor, usted tiene privilegios extendidos para préstamos de materiales.</p>
            </div>
            
            <div class="modules-grid">
                <a href="prestamos.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Solicitar Préstamo</h3>
                    <p>Realizar préstamos de materiales bibliográficos</p>
                    <small><strong>Límite: 6 préstamos simultáneos</strong></small>
                </a>
                
                <a href="mis-prestamos.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Mis Préstamos Activos</h3>
                    <p>Consultar y gestionar sus préstamos actuales</p>
                </a>
                
                <a href="historial.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Historial de Préstamos</h3>
                    <p>Ver su historial completo de préstamos</p>
                </a>
            </div>
        </div>
    </main>
</body>
</html>