<%-- 
    Document   : dashboard-alumno
    Created on : 11-27-2025, 08:09:07 PM
    Author     : josed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String usuarioTipo = (String) session.getAttribute("usuarioTipo");
    if (usuarioTipo == null || !"ALUMNO".equals(usuarioTipo)) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Panel del Alumno - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <style>
        .privilege-badge {
            background: #e67e22;
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
            <h1> Panel del Alumno <span class="privilege-badge">3 préstamos simultáneos</span></h1>
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
            <div class="welcome-banner" style="background: linear-gradient(135deg, #d35400, #e67e22);">
                <h2>Bienvenido Alumno</h2>
                <p>Consulte materiales y realice préstamos según los límites establecidos.</p>
            </div>
            
            <div class="modules-grid">
                <a href="prestamos.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Solicitar Préstamo</h3>
                    <p>Realizar préstamos de materiales bibliográficos</p>
                    <small><strong>Límite: 3 préstamos simultáneos</strong></small>
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
                
                <a href="estado-mora.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Estado de Mora</h3>
                    <p>Consultar moras pendientes de pago</p>
                </a>
            </div>
        </div>
    </main>
</body>
</html>