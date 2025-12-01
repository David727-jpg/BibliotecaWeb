<%-- 
    Document   : reportes
    Created on : 11-29-2025, 09:21:06 PM
    Author     : josed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificar si es administrador
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
    <title>Reportes y Estadísticas - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <style>
        .reportes-container {
            padding: 2rem 0;
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
        
        .reportes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        
        .reporte-card {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .reporte-card h3 {
            color: #2c3e50;
            margin-bottom: 1rem;
            border-bottom: 2px solid #ecf0f1;
            padding-bottom: 0.5rem;
        }
        
        .filtros {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }
        
        .filtro-group {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .filtro-group label {
            font-weight: bold;
            color: #2c3e50;
            min-width: 120px;
        }
        
        .filtro-group input, .filtro-group select {
            padding: 8px;
            border: 1px solid #bdc3c7;
            border-radius: 4px;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
        }
        
        .lista-reporte {
            max-height: 300px;
            overflow-y: auto;
        }
        
        .item-reporte {
            padding: 0.75rem;
            border-bottom: 1px solid #ecf0f1;
            display: flex;
            justify-content: space-between;
        }
        
        .item-reporte:last-child {
            border-bottom: none;
        }
        
        .numero {
            font-weight: bold;
            color: #3498db;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1> Reportes y Estadísticas</h1>
            <nav>
                <span><%= session.getAttribute("usuarioNombre") %> (Admin)</span>
                <a href="dashboard.jsp">Dashboard</a>
                <a href="gestion-ejemplares.jsp">Ejemplares</a>
                <a href="gestion-usuarios.jsp">Usuarios</a>
                <a href="gestion-prestamos.jsp">Préstamos</a>
                <a href="configuracion.jsp">Configuración</a>
                <form action="../LogoutServlet" method="post" style="display: inline;">
                    <button type="submit" class="logout-btn">Cerrar Sesión</button>
                </form>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="reportes-container">
            <!-- Estadísticas rápidas -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number" id="totalEjemplares">1,245</div>
                    <div class="stat-label">Total Ejemplares</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="totalUsuarios">890</div>
                    <div class="stat-label">Usuarios Registrados</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="prestamosMes">234</div>
                    <div class="stat-label">Préstamos este Mes</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="moraAcumulada">$450</div>
                    <div class="stat-label">Mora Acumulada</div>
                </div>
            </div>

            <!-- Filtros para reportes -->
            <div class="filtros">
                <h3> Filtros de Reportes</h3>
                <div class="filtro-group">
                    <label for="fechaInicio">Fecha Inicio:</label>
                    <input type="date" id="fechaInicio">
                    
                    <label for="fechaFin">Fecha Fin:</label>
                    <input type="date" id="fechaFin">
                    
                    <label for="tipoReporte">Tipo de Reporte:</label>
                    <select id="tipoReporte">
                        <option value="prestamos">Préstamos</option>
                        <option value="usuarios">Usuarios</option>
                        <option value="ejemplares">Ejemplares</option>
                        <option value="moras">Moras</option>
                    </select>
                    
                    <button class="btn-primary" onclick="generarReporte()">Generar Reporte</button>
                </div>
            </div>

            <!-- Grid de reportes -->
            <div class="reportes-grid">
                <!-- Reporte 1: Ejemplares más prestados -->
                <div class="reporte-card">
                    <h3> Ejemplares Más Prestados</h3>
                    <div class="lista-reporte">
                        <div class="item-reporte">
                            <span>Introducción a la Programación</span>
                            <span class="numero">45</span>
                        </div>
                        <div class="item-reporte">
                            <span>Base de Datos Avanzadas</span>
                            <span class="numero">38</span>
                        </div>
                        <div class="item-reporte">
                            <span>Matemáticas Discretas</span>
                            <span class="numero">32</span>
                        </div>
                        <div class="item-reporte">
                            <span>Historia del Arte Moderno</span>
                            <span class="numero">28</span>
                        </div>
                        <div class="item-reporte">
                            <span>Química Orgánica</span>
                            <span class="numero">25</span>
                        </div>
                    </div>
                </div>

                <!-- Reporte 2: Usuarios más activos -->
                <div class="reporte-card">
                    <h3> Usuarios Más Activos</h3>
                    <div class="lista-reporte">
                        <div class="item-reporte">
                            <span>Ana García Hernández</span>
                            <span class="numero">15</span>
                        </div>
                        <div class="item-reporte">
                            <span>Prof. Carlos Rodríguez</span>
                            <span class="numero">12</span>
                        </div>
                        <div class="item-reporte">
                            <span>Luis Martínez Pérez</span>
                            <span class="numero">10</span>
                        </div>
                        <div class="item-reporte">
                            <span>María José López</span>
                            <span class="numero">8</span>
                        </div>
                        <div class="item-reporte">
                            <span>Juan David Silva</span>
                            <span class="numero">7</span>
                        </div>
                    </div>
                </div>

                <!-- Reporte 3: Moras por usuario -->
                <div class="reporte-card">
                    <h3> Moras Pendientes</h3>
                    <div class="lista-reporte">
                        <div class="item-reporte">
                            <span>María José López</span>
                            <span class="numero">$12.00</span>
                        </div>
                        <div class="item-reporte">
                            <span>Carlos Eduardo Ramírez</span>
                            <span class="numero">$8.50</span>
                        </div>
                        <div class="item-reporte">
                            <span>Ana Patricia Gómez</span>
                            <span class="numero">$5.00</span>
                        </div>
                        <div class="item-reporte">
                            <span>Luis Fernando Torres</span>
                            <span class="numero">$3.00</span>
                        </div>
                        <div class="item-reporte">
                            <span>Karla Elizabeth Reyes</span>
                            <span class="numero">$2.50</span>
                        </div>
                    </div>
                </div>

                <!-- Reporte 4: Préstamos por carrera -->
                <div class="reporte-card">
                    <h3> Préstamos por Carrera</h3>
                    <div class="lista-reporte">
                        <div class="item-reporte">
                            <span>Ingeniería en Computación</span>
                            <span class="numero">156</span>
                        </div>
                        <div class="item-reporte">
                            <span>Administración de Empresas</span>
                            <span class="numero">134</span>
                        </div>
                        <div class="item-reporte">
                            <span>Psicología</span>
                            <span class="numero">98</span>
                        </div>
                        <div class="item-reporte">
                            <span>Derecho</span>
                            <span class="numero">87</span>
                        </div>
                        <div class="item-reporte">
                            <span>Medicina</span>
                            <span class="numero">76</span>
                        </div>
                    </div>
                </div>

                <!-- Reporte 5: Materiales nunca prestados -->
                <div class="reporte-card">
                    <h3> Materiales Sin Préstamos</h3>
                    <div class="lista-reporte">
                        <div class="item-reporte">
                            <span>Física Cuántica Avanzada</span>
                            <span>Estante F-25</span>
                        </div>
                        <div class="item-reporte">
                            <span>Historia Antigua de Grecia</span>
                            <span>Estante H-12</span>
                        </div>
                        <div class="item-reporte">
                            <span>Manual de Contabilidad 1995</span>
                            <span>Estante C-08</span>
                        </div>
                        <div class="item-reporte">
                            <span>CD: Música Clásica Rusa</span>
                            <span>Estante M-03</span>
                        </div>
                    </div>
                </div>

                <!-- Reporte 6: Estadísticas mensuales -->
                <div class="reporte-card">
                    <h3> Tendencia Mensual</h3>
                    <div class="lista-reporte">
                        <div class="item-reporte">
                            <span>Enero 2024</span>
                            <span class="numero">245</span>
                        </div>
                        <div class="item-reporte">
                            <span>Febrero 2024</span>
                            <span class="numero">287</span>
                        </div>
                        <div class="item-reporte">
                            <span>Marzo 2024</span>
                            <span class="numero">312</span>
                        </div>
                        <div class="item-reporte">
                            <span>Abril 2024</span>
                            <span class="numero">298</span>
                        </div>
                        <div class="item-reporte">
                            <span>Mayo 2024</span>
                            <span class="numero">275</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Acciones de exportación -->
            <div style="text-align: center; margin-top: 2rem; padding: 1.5rem; background: white; border-radius: 8px;">
                <h3>📤 Exportar Reportes</h3>
                <p>Genere reportes detallados en diferentes formatos:</p>
                <div style="display: flex; gap: 1rem; justify-content: center; margin-top: 1rem;">
                    <button class="btn-primary" onclick="exportarPDF()"> Exportar PDF</button>
                    <button class="btn-primary" onclick="exportarExcel()"> Exportar Excel</button>
                    <button class="btn-primary" onclick="exportarCSV()"> Exportar CSV</button>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Biblioteca Universidad Don Bosco - Reportes y Estadísticas</p>
        </div>
    </footer>

    <script>
        function generarReporte() {
            const fechaInicio = document.getElementById('fechaInicio').value;
            const fechaFin = document.getElementById('fechaFin').value;
            const tipoReporte = document.getElementById('tipoReporte').value;
            
            if (!fechaInicio || !fechaFin) {
                alert('Por favor seleccione un rango de fechas');
                return;
            }
            
            alert(`Generando reporte ${tipoReporte} del ${fechaInicio} al ${fechaFin} - Esta funcionalidad se conectará con Java`);
        }
        
        function exportarPDF() {
            alert('Exportando reporte en PDF - Esta funcionalidad se conectará con Java');
        }
        
        function exportarExcel() {
            alert('Exportando reporte en Excel - Esta funcionalidad se conectará con Java');
        }
        
        function exportarCSV() {
            alert('Exportando reporte en CSV - Esta funcionalidad se conectará con Java');
        }
        
        // Establecer fechas por defecto (mes actual)
        document.addEventListener('DOMContentLoaded', function() {
            const hoy = new Date();
            const primerDiaMes = new Date(hoy.getFullYear(), hoy.getMonth(), 1);
            const ultimoDiaMes = new Date(hoy.getFullYear(), hoy.getMonth() + 1, 0);
            
            document.getElementById('fechaInicio').value = primerDiaMes.toISOString().split('T')[0];
            document.getElementById('fechaFin').value = ultimoDiaMes.toISOString().split('T')[0];
        });
    </script>
</body>
</html>