<%-- 
    Document   : prestamos
    Created on : 11-28-2025, 12:30:28 AM
    Author     : josed
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String usuarioTipo = (String) session.getAttribute("usuarioTipo");
    if (usuarioTipo == null || (!"ALUMNO".equals(usuarioTipo) && !"PROFESOR".equals(usuarioTipo))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    int limitePrestamos = "PROFESOR".equals(usuarioTipo) ? 6 : 3;
    String tipoUsuario = "PROFESOR".equals(usuarioTipo) ? "Profesor" : "Alumno";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitar Préstamo - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <style>
        .prestamo-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .info-box {
            background: #e8f4fd;
            border-left: 4px solid #3498db;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 4px;
        }
        
        .search-section {
            margin-bottom: 2rem;
        }
        
        .search-results {
            margin-top: 1.5rem;
        }
        
        .ejemplar-item {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1rem;
            border-left: 4px solid #27ae60;
        }
        
        .btn-prestamo {
            background: #27ae60;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-prestamo:disabled {
            background: #95a5a6;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1> Solicitar Préstamo</h1>
            <nav>
                <span><%= session.getAttribute("usuarioNombre") %> (<%= tipoUsuario %>)</span>
                <a href="dashboard-<%= "PROFESOR".equals(usuarioTipo) ? "profesor" : "alumno" %>.jsp">Mi Panel</a>
                <a href="../publico/index.html">Catálogo Público</a>
                <form action="../LogoutServlet" method="post" style="display: inline;">
                    <button type="submit" class="logout-btn">Cerrar Sesión</button>
                </form>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="prestamo-container">
            <div class="info-box">
                <h3> Información de Préstamos</h3>
                <p><strong>Límite de préstamos simultáneos:</strong> <%= limitePrestamos %> materiales</p>
                <p><strong>Tiempo de préstamo:</strong> <%= "PROFESOR".equals(usuarioTipo) ? "30 días" : "15 días" %></p>
                <p><strong>Mora diaria:</strong> $1.00 por día de retraso</p>
            </div>

            <div class="search-section">
                <h3>🔍 Buscar Material para Préstamo</h3>
                <form id="formBusqueda">
                    <input type="text" id="terminoBusqueda" placeholder="Título, autor, ISBN..." style="width: 70%; padding: 10px;">
                    <button type="submit" style="padding: 10px 20px;">Buscar</button>
                </form>
            </div>

            <div class="search-results">
                <h4>Resultados de Búsqueda</h4>
                <div id="resultadosBusqueda">
                    <p>Realice una búsqueda para ver los materiales disponibles.</p>
                </div>
            </div>
        </div>

        <!-- Ejemplo de cómo se verá un resultado -->
        <template id="templateEjemplar">
            <div class="ejemplar-item">
                <h4 data-id="titulo">Título del Ejemplar</h4>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin: 1rem 0;">
                    <div><strong>Autor:</strong> <span data-id="autor">Nombre del autor</span></div>
                    <div><strong>Tipo:</strong> <span data-id="tipo">Libro</span></div>
                    <div><strong>Ubicación:</strong> <span data-id="ubicacion">Estante A-15</span></div>
                    <div><strong>Disponibles:</strong> <span data-id="disponibles">3 ejemplares</span></div>
                </div>
                <button class="btn-prestamo" data-id="botonPrestamo">Solicitar Préstamo</button>
            </div>
        </template>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Biblioteca Universidad Don Bosco - Módulo de Préstamos</p>
        </div>
    </footer>

    <script>
        document.getElementById('formBusqueda').addEventListener('submit', function(e) {
            e.preventDefault();
            const termino = document.getElementById('terminoBusqueda').value;
            
            if (termino.trim() === '') {
                alert('Por favor ingrese un término de búsqueda');
                return;
            }
            
            // Simulación de búsqueda - luego se conectará con Java
            simularBusqueda(termino);
        });

        function simularBusqueda(termino) {
            const resultados = document.getElementById('resultadosBusqueda');
            resultados.innerHTML = '<p>Buscando: <strong>' + termino + '</strong>...</p>';
            
            // Simular delay de búsqueda
            setTimeout(() => {
                // Esto es temporal - luego vendrá de Java
                resultados.innerHTML = `
                    <div class="ejemplar-item">
                        <h4>Introducción a la Programación</h4>
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin: 1rem 0;">
                            <div><strong>Autor:</strong> Juan Pérez</div>
                            <div><strong>Tipo:</strong> Libro</div>
                            <div><strong>Ubicación:</strong> Estante A-15</div>
                            <div><strong>Disponibles:</strong> 5 ejemplares</div>
                        </div>
                        <button class="btn-prestamo" onclick="solicitarPrestamo(1)">Solicitar Préstamo</button>
                    </div>
                    
                    <div class="ejemplar-item">
                        <h4>Base de Datos Avanzadas</h4>
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin: 1rem 0;">
                            <div><strong>Autor:</strong> María González</div>
                            <div><strong>Tipo:</strong> Libro</div>
                            <div><strong>Ubicación:</strong> Estante B-22</div>
                            <div><strong>Disponibles:</strong> 2 ejemplares</div>
                        </div>
                        <button class="btn-prestamo" onclick="solicitarPrestamo(2)">Solicitar Préstamo</button>
                    </div>
                `;
            }, 1000);
        }

        function solicitarPrestamo(idEjemplar) {
            if (confirm('¿Confirmar solicitud de préstamo?')) {
                alert('Préstamo solicitado correctamente. ID: ' + idEjemplar);
                // Aquí luego se llamará al Servlet de préstamos
            }
        }
    </script>
</body>
</html>

