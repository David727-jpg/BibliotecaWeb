<%-- 
    Document   : gestion-usuarios
    Created on : 11-28-2025, 10:08:47 PM
    Author     : arlhz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <title>Gestión de Usuarios - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <style>
        .gestion-container {
            padding: 2rem 0;
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
        
        .badge-admin { background: #e74c3c; color: white; }
        .badge-profesor { background: #9b59b6; color: white; }
        .badge-alumno { background: #3498db; color: white; }
        
        .estado-activo { color: #27ae60; font-weight: bold; }
        .estado-inactivo { color: #95a5a6; font-weight: bold; }
        
        .mora-alta { color: #e74c3c; font-weight: bold; }
        .mora-baja { color: #f39c12; font-weight: bold; }
        .mora-cero { color: #27ae60; font-weight: bold; }
        
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
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1> Gestión de Usuarios</h1>
            <nav>
                <span><%= session.getAttribute("usuarioNombre") %> (Admin)</span>
                <a href="dashboard.jsp">Dashboard</a>
                <a href="gestion-ejemplares.jsp">Ejemplares</a>
                <a href="gestion-prestamos.jsp">Préstamos</a>
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
                    <div class="stat-number" id="totalUsuarios">--</div>
                    <div class="stat-label">Total Usuarios</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="totalAlumnos">--</div>
                    <div class="stat-label">Alumnos</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="totalProfesores">--</div>
                    <div class="stat-label">Profesores</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="usuariosActivos">--</div>
                    <div class="stat-label">Usuarios Activos</div>
                </div>
            </div>

            <!-- Header con búsqueda y acciones -->
            <div class="header-actions">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Buscar por nombre, email...">
                    <button class="btn-primary" onclick="buscarUsuarios()">🔍 Buscar</button>
                </div>
                <a href="agregar-usuario.jsp" class="btn-success">➕ Agregar Usuario</a>
            </div>

            <!-- Filtros -->
            <div class="filters">
                <div class="filter-group">
                    <label>Tipo:</label>
                    <select id="filterTipo" onchange="filtrarUsuarios()">
                        <option value="">Todos los tipos</option>
                        <option value="ADMINISTRADOR">Administradores</option>
                        <option value="PROFESOR">Profesores</option>
                        <option value="ALUMNO">Alumnos</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label>Estado:</label>
                    <select id="filterEstado" onchange="filtrarUsuarios()">
                        <option value="">Todos</option>
                        <option value="activo">Activos</option>
                        <option value="inactivo">Inactivos</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label>Mora:</label>
                    <select id="filterMora" onchange="filtrarUsuarios()">
                        <option value="">Todas</option>
                        <option value="con-mora">Con Mora</option>
                        <option value="sin-mora">Sin Mora</option>
                    </select>
                </div>
            </div>

            <!-- Tabla de usuarios -->
            <div class="table-container">
                <table id="tablaUsuarios">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Email</th>
                            <th>Tipo</th>
                            <th>Estado</th>
                            <th>Mora</th>
                            <th>Registro</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyUsuarios">
                        <!-- Los datos se cargarán con JavaScript -->
                        <tr>
                            <td colspan="8" style="text-align: center; padding: 2rem;">
                                <p>Cargando usuarios...</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Paginación -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 1rem;">
                <div id="infoPaginacion">
                    Mostrando 0 de 0 usuarios
                </div>
                <div>
                    <button id="btnAnterior" onclick="cambiarPagina(-1)" disabled>← Anterior</button>
                    <span id="infoPaginaActual" style="margin: 0 1rem;">Página 1</span>
                    <button id="btnSiguiente" onclick="cambiarPagina(1)" disabled>Siguiente →</button>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Biblioteca Universidad Don Bosco - Gestión de Usuarios</p>
        </div>
    </footer>

    <!-- Template para filas de usuarios -->
    <template id="templateUsuario">
        <tr>
            <td data-id="id">1</td>
            <td data-id="nombre">Nombre Usuario</td>
            <td data-id="email">usuario@udb.edu.sv</td>
            <td>
                <span class="badge" data-id="badgeTipo">ALUMNO</span>
            </td>
            <td>
                <span data-id="estado" class="estado-activo">Activo</span>
            </td>
            <td>
                <span data-id="mora" class="mora-cero">$0.00</span>
            </td>
            <td data-id="registro">2024-01-01</td>
            <td>
                <div class="actions-cell">
                    <button class="btn-warning" data-id="btnEditar" onclick="editarUsuario(1)">✏️ Editar</button>
                    <button class="btn-info" data-id="btnPassword" onclick="restablecerPassword(1)">🔑 Password</button>
                    <button class="btn-danger" data-id="btnEstado" onclick="cambiarEstado(1)">🚫 Desactivar</button>
                </div>
            </td>
        </tr>
    </template>

    <script>
        let usuarios = [];
        let paginaActual = 1;
        const elementosPorPagina = 10;
        
        // Cargar usuarios al iniciar
        document.addEventListener('DOMContentLoaded', function() {
            cargarUsuarios();
        });
        
        function cargarUsuarios() {
            // Simulación - luego se conectará con Java
            simularCargaUsuarios();
        }
        
        function simularCargaUsuarios() {
            // Datos de ejemplo - luego vendrán de Java
            usuarios = [
                {
                    id: 1,
                    nombre: "Administrador Principal",
                    email: "admin@udb.edu.sv",
                    tipo: "ADMINISTRADOR",
                    estado: "activo",
                    mora: 0.00,
                    registro: "2024-01-15"
                },
                {
                    id: 2,
                    nombre: "Profesor Carlos Rodríguez", 
                    email: "carlos.rodriguez@udb.edu.sv",
                    tipo: "PROFESOR",
                    estado: "activo",
                    mora: 0.00,
                    registro: "2024-02-10"
                },
                {
                    id: 3,
                    nombre: "Ana García Hernández",
                    tipo: "ALUMNO", 
                    email: "ana.garcia@udb.edu.sv",
                    estado: "activo",
                    mora: 5.50,
                    registro: "2024-03-05"
                },
                {
                    id: 4,
                    nombre: "Luis Martínez Pérez",
                    tipo: "ALUMNO",
                    email: "luis.martinez@udb.edu.sv", 
                    estado: "activo",
                    mora: 0.00,
                    registro: "2024-03-12"
                },
                {
                    id: 5,
                    nombre: "María José López",
                    tipo: "ALUMNO",
                    email: "maria.lopez@udb.edu.sv",
                    estado: "inactivo", 
                    mora: 12.00,
                    registro: "2024-01-20"
                }
            ];
            
            mostrarUsuarios();
            actualizarEstadisticas();
        }
        
        function mostrarUsuarios() {
            const tbody = document.getElementById('tbodyUsuarios');
            const template = document.getElementById('templateUsuario');
            
            tbody.innerHTML = '';
            
            if (usuarios.length === 0) {
                tbody.innerHTML = '<tr><td colspan="8" style="text-align: center; padding: 2rem;">No se encontraron usuarios</td></tr>';
                return;
            }
            
            usuarios.forEach(usuario => {
                const clone = template.content.cloneNode(true);
                
                // Llenar datos
                clone.querySelector('[data-id="id"]').textContent = usuario.id;
                clone.querySelector('[data-id="nombre"]').textContent = usuario.nombre;
                clone.querySelector('[data-id="email"]').textContent = usuario.email;
                
                // Tipo con badge
                const badge = clone.querySelector('[data-id="badgeTipo"]');
                badge.textContent = usuario.tipo;
                badge.className = 'badge badge-' + usuario.tipo.toLowerCase();
                
                // Estado
                const estado = clone.querySelector('[data-id="estado"]');
                estado.textContent = usuario.estado === 'activo' ? 'Activo' : 'Inactivo';
                estado.className = usuario.estado === 'activo' ? 'estado-activo' : 'estado-inactivo';
                
                // Mora
                const mora = clone.querySelector('[data-id="mora"]');
                mora.textContent = `$${usuario.mora.toFixed(2)}`;
                if (usuario.mora === 0) {
                    mora.className = 'mora-cero';
                } else if (usuario.mora > 10) {
                    mora.className = 'mora-alta';
                } else {
                    mora.className = 'mora-baja';
                }
                
                clone.querySelector('[data-id="registro"]').textContent = usuario.registro;
                
                // Actualizar eventos
                clone.querySelector('[data-id="btnEditar"]').onclick = () => editarUsuario(usuario.id);
                clone.querySelector('[data-id="btnPassword"]').onclick = () => restablecerPassword(usuario.id);
                clone.querySelector('[data-id="btnEstado"]').onclick = () => cambiarEstado(usuario.id);
                
                // Actualizar texto del botón de estado
                const btnEstado = clone.querySelector('[data-id="btnEstado"]');
                btnEstado.textContent = usuario.estado === 'activo' ? '🚫 Desactivar' : '✅ Activar';
                
                tbody.appendChild(clone);
            });
            
            actualizarPaginacion();
        }
        
        function actualizarEstadisticas() {
            const totalUsuarios = usuarios.length;
            const totalAlumnos = usuarios.filter(u => u.tipo === 'ALUMNO').length;
            const totalProfesores = usuarios.filter(u => u.tipo === 'PROFESOR').length;
            const usuariosActivos = usuarios.filter(u => u.estado === 'activo').length;
            
            document.getElementById('totalUsuarios').textContent = totalUsuarios;
            document.getElementById('totalAlumnos').textContent = totalAlumnos;
            document.getElementById('totalProfesores').textContent = totalProfesores;
            document.getElementById('usuariosActivos').textContent = usuariosActivos;
        }
        
        function buscarUsuarios() {
            const termino = document.getElementById('searchInput').value.toLowerCase();
            // Aquí luego se filtrará desde Java
            alert('Buscando: ' + termino + ' - Esta funcionalidad se conectará con Java');
        }
        
        function filtrarUsuarios() {
            // Aquí luego se aplicarán filtros desde Java
            console.log('Filtrando usuarios...');
        }
        
        function cambiarPagina(direccion) {
            paginaActual += direccion;
            mostrarUsuarios();
        }
        
        function actualizarPaginacion() {
            document.getElementById('infoPaginacion').textContent = 
                `Mostrando ${usuarios.length} usuarios`;
                
            document.getElementById('infoPaginaActual').textContent = 
                `Página ${paginaActual}`;
        }
        
        function editarUsuario(id) {
            alert(`Editando usuario ID: ${id} - Esta funcionalidad se conectará con Java`);
        }
        
        function restablecerPassword(id) {
            if (confirm('¿Restablecer contraseña del usuario?')) {
                alert(`Contraseña restablecida para usuario ID: ${id} - Nueva contraseña: 1234`);
            }
        }
        
        function cambiarEstado(id) {
            const usuario = usuarios.find(u => u.id === id);
            const nuevoEstado = usuario.estado === 'activo' ? 'inactivo' : 'activo';
            const accion = nuevoEstado === 'activo' ? 'activar' : 'desactivar';
            
            if (confirm(`¿${accion.toUpperCase()} al usuario ${usuario.nombre}?`)) {
                alert(`${accion.charAt(0).toUpperCase() + accion.slice(1)} usuario ID: ${id}`);
                // Aquí luego se actualizará en Java
            }
        }
    </script>
</body>
</html>