<%-- 
    Document   : gestion-prestamos
    Created on : 11-29-2025, 12:26:19 AM
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
    <title>Gestión de Préstamos - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <style>
        .gestion-container {
            padding: 2rem 0;
        }
        
        .tabs {
            display: flex;
            border-bottom: 2px solid #ecf0f1;
            margin-bottom: 2rem;
        }
        
        .tab {
            padding: 1rem 2rem;
            background: #f8f9fa;
            border: none;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            transition: all 0.3s;
        }
        
        .tab.active {
            background: white;
            border-bottom: 3px solid #3498db;
            font-weight: bold;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .header-actions {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 2rem;
            gap: 1rem;
        }
        
        .search-box {
            display: flex;
            gap: 1rem;
            flex: 1;
        }
        
        .search-box input {
            flex: 1;
            padding: 10px;
            border: 2px solid #bdc3c7;
            border-radius: 6px;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-success {
            background: #27ae60;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-warning {
            background: #f39c12;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-danger {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-info {
            background: #17a2b8;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .table-container {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ecf0f1;
        }
        
        th {
            background: #34495e;
            color: white;
            font-weight: 600;
        }
        
        tr:hover {
            background: #f8f9fa;
        }
        
        .badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .badge-activo { background: #3498db; color: white; }
        .badge-devuelto { background: #27ae60; color: white; }
        .badge-vencido { background: #e74c3c; color: white; }
        
        .estado-al-dia { color: #27ae60; font-weight: bold; }
        .estado-mora { color: #e74c3c; font-weight: bold; }
        .estado-proximo { color: #f39c12; font-weight: bold; }
        
        .actions-cell {
            display: flex;
            gap: 0.5rem;
        }
        
        .filters {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }
        
        .filter-group {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .filter-group select {
            padding: 8px;
            border: 1px solid #bdc3c7;
            border-radius: 4px;
        }
        
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
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
            font-size: 2rem;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .stat-label {
            color: #7f8c8d;
            font-size: 0.9rem;
        }
        
        .alert-banner {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1rem;
        }
        
        .prestamo-card {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 1rem;
            border-left: 4px solid #3498db;
        }
        
        .prestamo-card.vencido {
            border-left-color: #e74c3c;
            background: #fdf2f2;
        }
        
        .prestamo-card.proximo {
            border-left-color: #f39c12;
            background: #fef9e7;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1>📋 Gestión de Préstamos</h1>
            <nav>
                <span><%= session.getAttribute("usuarioNombre") %> (Admin)</span>
                <a href="dashboard.jsp">Dashboard</a>
                <a href="gestion-ejemplares.jsp">Ejemplares</a>
                <a href="gestion-usuarios.jsp">Usuarios</a>
                <a href="configuracion.jsp">Configuración</a>
                <a href="reportes.jsp">Reportes</a>
                <form action="../LogoutServlet" method="post" style="display: inline;">
                    <button type="submit" class="logout-btn">Cerrar Sesión</button>
                </form>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="gestion-container">
            <!-- Tarjetas de estadísticas -->
            <div class="stats-cards">
                <div class="stat-card">
                    <div class="stat-number" id="totalPrestamos">--</div>
                    <div class="stat-label">Total Préstamos</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="prestamosActivos">--</div>
                    <div class="stat-label">Préstamos Activos</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="prestamosVencidos">--</div>
                    <div class="stat-label">Préstamos Vencidos</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="moraTotal">--</div>
                    <div class="stat-label">Mora Total</div>
                </div>
            </div>

            <!-- Pestañas -->
            <div class="tabs">
                <button class="tab active" onclick="cambiarTab('activos')">📖 Préstamos Activos</button>
                <button class="tab" onclick="cambiarTab('vencidos')">⏰ Préstamos Vencidos</button>
                <button class="tab" onclick="cambiarTab('historial')">📊 Historial Completo</button>
                <button class="tab" onclick="cambiarTab('devoluciones')">✅ Registrar Devolución</button>
            </div>

            <!-- Contenido de pestaña: PRÉSTAMOS ACTIVOS -->
            <div id="tab-activos" class="tab-content active">
                <div class="header-actions">
                    <div class="search-box">
                        <input type="text" id="searchActivos" placeholder="Buscar por usuario, ejemplar...">
                        <button class="btn-primary" onclick="buscarPrestamosActivos()">🔍 Buscar</button>
                    </div>
                </div>

                <div class="filters">
                    <div class="filter-group">
                        <label>Tipo Usuario:</label>
                        <select id="filterTipoActivos" onchange="filtrarPrestamosActivos()">
                            <option value="">Todos</option>
                            <option value="ALUMNO">Alumnos</option>
                            <option value="PROFESOR">Profesores</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label>Estado:</label>
                        <select id="filterEstadoActivos" onchange="filtrarPrestamosActivos()">
                            <option value="">Todos</option>
                            <option value="al-dia">Al día</option>
                            <option value="proximo">Próximo a vencer</option>
                            <option value="mora">En mora</option>
                        </select>
                    </div>
                </div>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Ejemplar</th>
                                <th>Fecha Préstamo</th>
                                <th>Fecha Devolución</th>
                                <th>Días Restantes</th>
                                <th>Estado</th>
                                <th>Mora</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyActivos">
                            <tr>
                                <td colspan="9" style="text-align: center; padding: 2rem;">
                                    <p>Cargando préstamos activos...</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Contenido de pestaña: PRÉSTAMOS VENCIDOS -->
            <div id="tab-vencidos" class="tab-content">
                <div class="alert-banner">
                    ⚠️ <strong>Préstamos vencidos detectados:</strong> Se recomienda contactar a los usuarios.
                </div>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Ejemplar</th>
                                <th>Fecha Préstamo</th>
                                <th>Fecha Devolución</th>
                                <th>Días de Retraso</th>
                                <th>Mora Acumulada</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyVencidos">
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 2rem;">
                                    <p>Cargando préstamos vencidos...</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Contenido de pestaña: HISTORIAL -->
            <div id="tab-historial" class="tab-content">
                <div class="header-actions">
                    <div class="search-box">
                        <input type="text" id="searchHistorial" placeholder="Buscar en historial...">
                        <button class="btn-primary" onclick="buscarHistorial()">🔍 Buscar</button>
                    </div>
                </div>

                <div class="filters">
                    <div class="filter-group">
                        <label>Fecha desde:</label>
                        <input type="date" id="fechaDesde">
                    </div>
                    
                    <div class="filter-group">
                        <label>Fecha hasta:</label>
                        <input type="date" id="fechaHasta">
                    </div>
                    
                    <div class="filter-group">
                        <label>Estado:</label>
                        <select id="filterEstadoHistorial">
                            <option value="">Todos</option>
                            <option value="ACTIVO">Activos</option>
                            <option value="DEVUELTO">Devueltos</option>
                            <option value="VENCIDO">Vencidos</option>
                        </select>
                    </div>
                    
                    <button class="btn-primary" onclick="aplicarFiltrosHistorial()">Aplicar Filtros</button>
                </div>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Ejemplar</th>
                                <th>Fecha Préstamo</th>
                                <th>Fecha Devolución</th>
                                <th>Estado</th>
                                <th>Mora Final</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyHistorial">
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 2rem;">
                                    <p>Cargando historial...</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Contenido de pestaña: REGISTRAR DEVOLUCIÓN -->
            <div id="tab-devoluciones" class="tab-content">
                <div class="prestamo-card">
                    <h3>📚 Registrar Devolución</h3>
                    <p>Busque un préstamo activo para registrar su devolución.</p>
                    
                    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 1rem; margin-top: 1rem;">
                        <input type="text" id="buscarDevolucion" placeholder="Buscar por ID de préstamo, usuario o ejemplar...">
                        <button class="btn-primary" onclick="buscarParaDevolucion()">🔍 Buscar Préstamo</button>
                    </div>
                </div>

                <div id="resultadoDevolucion" style="display: none;">
                    <!-- Aquí se mostrará el préstamo encontrado -->
                </div>

                <div id="sinResultados" style="text-align: center; padding: 2rem; display: none;">
                    <p>No se encontraron préstamos activos con ese criterio.</p>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Biblioteca Universidad Don Bosco - Gestión de Préstamos</p>
        </div>
    </footer>

    <!-- Templates -->
    <template id="templatePrestamoActivo">
        <tr>
            <td data-id="id">1</td>
            <td data-id="usuario">Usuario</td>
            <td data-id="ejemplar">Ejemplar</td>
            <td data-id="fechaPrestamo">2024-01-01</td>
            <td data-id="fechaDevolucion">2024-01-15</td>
            <td data-id="diasRestantes">5 días</td>
            <td>
                <span class="badge" data-id="badgeEstado">ACTIVO</span>
            </td>
            <td data-id="mora">$0.00</td>
            <td>
                <div class="actions-cell">
                    <button class="btn-success" data-id="btnDevolver" onclick="registrarDevolucion(1)">✅ Devolver</button>
                    <button class="btn-info" data-id="btnRenovar" onclick="renovarPrestamo(1)">🔄 Renovar</button>
                    <button class="btn-warning" data-id="btnNotificar" onclick="notificarUsuario(1)">📧 Notificar</button>
                </div>
            </td>
        </tr>
    </template>

    <template id="templatePrestamoVencido">
        <tr>
            <td data-id="id">1</td>
            <td data-id="usuario">Usuario</td>
            <td data-id="ejemplar">Ejemplar</td>
            <td data-id="fechaPrestamo">2024-01-01</td>
            <td data-id="fechaDevolucion">2024-01-15</td>
            <td data-id="diasRetraso">5 días</td>
            <td data-id="mora">$5.00</td>
            <td>
                <div class="actions-cell">
                    <button class="btn-success" onclick="registrarDevolucion(1)">✅ Devolver</button>
                    <button class="btn-danger" onclick="aplicarMoraExtra(1)">💰 Mora Extra</button>
                    <button class="btn-warning" onclick="notificarUrgente(1)">🚨 Notificar</button>
                </div>
            </td>
        </tr>
    </template>

    <script>
        let prestamosActivos = [];
        let prestamosVencidos = [];
        let historialPrestamos = [];
        
        // Cargar datos al iniciar
        document.addEventListener('DOMContentLoaded', function() {
            cargarDatosPrestamos();
        });
        
        function cargarDatosPrestamos() {
            // Simulación - luego se conectará con Java
            simularCargaPrestamos();
        }
        
        function simularCargaPrestamos() {
            // Datos de ejemplo - luego vendrán de Java
            prestamosActivos = [
                {
                    id: 1,
                    usuario: "Ana García (Alumno)",
                    ejemplar: "Introducción a la Programación",
                    fechaPrestamo: "2024-03-01",
                    fechaDevolucion: "2024-03-16",
                    diasRestantes: 2,
                    estado: "proximo",
                    mora: 0.00
                },
                {
                    id: 2,
                    usuario: "Prof. Carlos Rodríguez", 
                    ejemplar: "Base de Datos Avanzadas",
                    fechaPrestamo: "2024-03-05",
                    fechaDevolucion: "2024-04-04",
                    diasRestantes: 25,
                    estado: "al-dia",
                    mora: 0.00
                },
                {
                    id: 3,
                    usuario: "Luis Martínez (Alumno)",
                    ejemplar: "Historia del Arte Moderno", 
                    fechaPrestamo: "2024-02-20",
                    fechaDevolucion: "2024-03-06",
                    diasRestantes: -3,
                    estado: "mora",
                    mora: 3.00
                }
            ];
            
            prestamosVencidos = [
                {
                    id: 4,
                    usuario: "María López (Alumno)",
                    ejemplar: "Química Orgánica",
                    fechaPrestamo: "2024-02-15", 
                    fechaDevolucion: "2024-03-01",
                    diasRetraso: 10,
                    mora: 10.00
                }
            ];
            
            historialPrestamos = [
                {
                    id: 5,
                    usuario: "Juan Pérez (Alumno)",
                    ejemplar: "Física Universitaria", 
                    fechaPrestamo: "2024-01-10",
                    fechaDevolucion: "2024-01-25",
                    estado: "DEVUELTO",
                    moraFinal: 0.00
                }
            ];
            
            mostrarPrestamosActivos();
            mostrarPrestamosVencidos();
            mostrarHistorial();
            actualizarEstadisticas();
        }
        
        function cambiarTab(tabName) {
            // Ocultar todos los tabs
            document.querySelectorAll('.tab').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.remove('active');
            });
            
            // Activar tab seleccionado
            document.querySelector(`[onclick="cambiarTab('${tabName}')"]`).classList.add('active');
            document.getElementById(`tab-${tabName}`).classList.add('active');
        }
        
        function mostrarPrestamosActivos() {
            const tbody = document.getElementById('tbodyActivos');
            const template = document.getElementById('templatePrestamoActivo');
            
            tbody.innerHTML = '';
            
            if (prestamosActivos.length === 0) {
                tbody.innerHTML = '<tr><td colspan="9" style="text-align: center; padding: 2rem;">No hay préstamos activos</td></tr>';
                return;
            }
            
            prestamosActivos.forEach(prestamo => {
                const clone = template.content.cloneNode(true);
                
                // Llenar datos
                clone.querySelector('[data-id="id"]').textContent = prestamo.id;
                clone.querySelector('[data-id="usuario"]').textContent = prestamo.usuario;
                clone.querySelector('[data-id="ejemplar"]').textContent = prestamo.ejemplar;
                clone.querySelector('[data-id="fechaPrestamo"]').textContent = prestamo.fechaPrestamo;
                clone.querySelector('[data-id="fechaDevolucion"]').textContent = prestamo.fechaDevolucion;
                
                // Días restantes con color
                const diasRestantes = clone.querySelector('[data-id="diasRestantes"]');
                diasRestantes.textContent = prestamo.diasRestantes >= 0 ? 
                    `${prestamo.diasRestantes} días` : 
                    `${Math.abs(prestamo.diasRestantes)} días de retraso`;
                
                if (prestamo.diasRestantes < 0) {
                    diasRestantes.className = 'estado-mora';
                } else if (prestamo.diasRestantes <= 2) {
                    diasRestantes.className = 'estado-proximo';
                } else {
                    diasRestantes.className = 'estado-al-dia';
                }
                
                // Estado con badge
                const badge = clone.querySelector('[data-id="badgeEstado"]');
                badge.textContent = prestamo.estado === 'mora' ? 'MORA' : 'ACTIVO';
                badge.className = prestamo.estado === 'mora' ? 'badge badge-vencido' : 'badge badge-activo';
                
                clone.querySelector('[data-id="mora"]').textContent = `$${prestamo.mora.toFixed(2)}`;
                
                // Actualizar eventos
                clone.querySelector('[data-id="btnDevolver"]').onclick = () => registrarDevolucion(prestamo.id);
                clone.querySelector('[data-id="btnRenovar"]').onclick = () => renovarPrestamo(prestamo.id);
                clone.querySelector('[data-id="btnNotificar"]').onclick = () => notificarUsuario(prestamo.id);
                
                tbody.appendChild(clone);
            });
        }
        
        function mostrarPrestamosVencidos() {
            const tbody = document.getElementById('tbodyVencidos');
            // Similar a mostrarPrestamosActivos pero para vencidos
        }
        
        function mostrarHistorial() {
            const tbody = document.getElementById('tbodyHistorial');
            // Similar a mostrarPrestamosActivos pero para historial
        }
        
        function actualizarEstadisticas() {
            document.getElementById('totalPrestamos').textContent = prestamosActivos.length + prestamosVencidos.length;
            document.getElementById('prestamosActivos').textContent = prestamosActivos.length;
            document.getElementById('prestamosVencidos').textContent = prestamosVencidos.length;
            
            const moraTotal = prestamosActivos.reduce((sum, p) => sum + p.mora, 0) +
                            prestamosVencidos.reduce((sum, p) => sum + p.mora, 0);
            document.getElementById('moraTotal').textContent = `$${moraTotal.toFixed(2)}`;
        }
        
        function registrarDevolucion(idPrestamo) {
            if (confirm('¿Registrar devolución de este préstamo?')) {
                alert(`Devolución registrada para préstamo ID: ${idPrestamo} - Esta funcionalidad se conectará con Java`);
                // Aquí luego se llamará al Servlet correspondiente
            }
        }
        
        function renovarPrestamo(idPrestamo) {
            if (confirm('¿Renovar este préstamo por 15 días más?')) {
                alert(`Préstamo renovado ID: ${idPrestamo} - Esta funcionalidad se conectará con Java`);
            }
        }
        
        function notificarUsuario(idPrestamo) {
            alert(`Notificación enviada para préstamo ID: ${idPrestamo} - Esta funcionalidad se conectará con Java`);
        }
        
        function buscarPrestamosActivos() {
            const termino = document.getElementById('searchActivos').value;
            alert(`Buscando préstamos activos: ${termino} - Esta funcionalidad se conectará con Java`);
        }
        
        function buscarParaDevolucion() {
            const termino = document.getElementById('buscarDevolucion').value;
            if (!termino) {
                alert('Ingrese un término de búsqueda');
                return;
            }
            alert(`Buscando para devolución: ${termino} - Esta funcionalidad se conectará con Java`);
        }
    </script>
</body>
</html>