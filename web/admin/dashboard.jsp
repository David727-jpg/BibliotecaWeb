<%-- 
    Document   : dashboard
    Created on : 11-27-2025, 08:02:59 PM
    Author     : josed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    // Verificar si el usuario está logueado y es administrador
    String usuarioTipo = (String) session.getAttribute("usuarioTipo");
    if (usuarioTipo == null || !"ADMINISTRADOR".equals(usuarioTipo)) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <style>
        .dashboard {
            padding: 2rem 0;
        }
        
        .welcome-banner {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: #7f8c8d;
            font-size: 0.9rem;
        }
        
        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        
        .module-card {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            text-decoration: none;
            color: inherit;
        }
        
        .module-card:hover {
            transform: translateY(-5px);
            text-decoration: none;
            color: inherit;
        }
        
        .module-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .logout-btn {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 1rem;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1> Panel de Administración</h1>
            <nav>
                <span>Bienvenido, <%= session.getAttribute("usuarioNombre") %></span>
                <a href="../publico/index.html">Sitio Público</a>
                <form action="../LogoutServlet" method="post" style="display: inline;">
                    <button type="submit" class="logout-btn">Cerrar Sesión</button>
                </form>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="dashboard">
            <div class="welcome-banner">
                <h2>Bienvenido al Sistema de Administración</h2>
                <p>Gestiona todos los aspectos de la biblioteca desde este panel central.</p>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number" id="total-ejemplares">--</div>
                    <div class="stat-label">Total de Ejemplares</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="total-usuarios">--</div>
                    <div class="stat-label">Usuarios Registrados</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="prestamos-activos">--</div>
                    <div class="stat-label">Préstamos Activos</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="mora-total">$0.00</div>
                    <div class="stat-label">Mora Pendiente</div>
                </div>
            </div>
            
            <div class="modules-grid">
                <a href="gestion-ejemplares.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Gestión de Ejemplares</h3>
                    <p>Agregar, editar y administrar todos los materiales de la biblioteca</p>
                </a>
                
                <a href="gestion-usuarios.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Gestión de Usuarios</h3>
                    <p>Administrar alumnos, profesores y otros usuarios del sistema</p>
                </a>
                
                <a href="gestion-prestamos.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Control de Préstamos</h3>
                    <p>Gestionar préstamos, devoluciones y calcular moras</p>
                </a>
                
                <a href="configuracion.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Configuración</h3>
                    <p>Configurar límites de préstamos, moras y parámetros del sistema</p>
                </a>
                
                <a href="reportes.jsp" class="module-card">
                    <div class="module-icon"></div>
                    <h3>Reportes y Estadísticas</h3>
                    <p>Generar reportes de uso y estadísticas de la biblioteca</p>
                </a>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Biblioteca Universidad Don Bosco - Panel de Administración</p>
        </div>
    </footer>

    <script>
        // Aquí luego cargarás estadísticas reales desde Java
        console.log("Panel de administración cargado");
    </script>
</body>
</html>