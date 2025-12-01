<%-- 
    Document   : gestion-ejemplares
    Created on : 11-28-2025, 10:01:12 PM
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
    <title>Gestión de Ejemplares - Biblioteca UDB</title>
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
        
        .btn-danger {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-warning {
            background: #f39c12;
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
        
        .badge-libro { background: #3498db; color: white; }
        .badge-revista { background: #9b59b6; color: white; }
        .badge-cd { background: #e67e22; color: white; }
        .badge-tesis { background: #e74c3c; color: white; }
        
        .disponible { color: #27ae60; font-weight: bold; }
        .agotado { color: #e74c3c; font-weight: bold; }
        
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
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1> Gestión de Ejemplares</h1>
            <nav>
                <span><%= session.getAttribute("usuarioNombre") %> (Admin)</span>
                <a href="dashboard.jsp">Dashboard</a>
                <a href="gestion-usuarios.jsp">Usuarios</a>
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
            <!-- Header con búsqueda y acciones -->
            <div class="header-actions">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Buscar por título, autor, ISBN...">
                    <button class="btn-primary" onclick="buscarEjemplares()"> Buscar</button>
                </div>
                <a href="agregar-ejemplar.jsp" class="btn-success"> Agregar Ejemplar</a>
            </div>

            <!-- Filtros -->
            <div class="filters">
                <div class="filter-group">
                    <label>Tipo:</label>
                    <select id="filterTipo" onchange="filtrarEjemplares()">
                        <option value="">Todos los tipos</option>
                        <option value="LIBRO">Libros</option>
                        <option value="REVISTA">Revistas</option>
                        <option value="CD">CDs/Multimedia</option>
                        <option value="TESIS">Tesis</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label>Disponibilidad:</label>
                    <select id="filterDisponibilidad" onchange="filtrarEjemplares()">
                        <option value="">Todas</option>
                        <option value="disponible">Disponibles</option>
                        <option value="agotado">Agotados</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label>Ordenar por:</label>
                    <select id="filterOrden" onchange="filtrarEjemplares()">
                        <option value="titulo">Título A-Z</option>
                        <option value="titulo_desc">Título Z-A</option>
                        <option value="disponibles">Más disponibles</option>
                        <option value="recientes">Más recientes</option>
                    </select>
                </div>
            </div>

            <!-- Tabla de ejemplares -->
            <div class="table-container">
                <table id="tablaEjemplares">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Título</th>
                            <th>Tipo</th>
                            <th>Autor/Editor</th>
                            <th>Ubicación</th>
                            <th>Disponibles</th>
                            <th>Año</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyEjemplares">
                        <!-- Los datos se cargarán con JavaScript -->
                        <tr>
                            <td colspan="8" style="text-align: center; padding: 2rem;">
                                <p>Cargando ejemplares...</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Paginación -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 1rem;">
                <div id="infoPaginacion">
                    Mostrando 0 de 0 ejemplares
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
            <p>&copy; 2024 Biblioteca Universidad Don Bosco - Gestión de Ejemplares</p>
        </div>
    </footer>

    <!-- Template para filas de ejemplares -->
    <template id="templateEjemplar">
        <tr>
            <td data-id="id">1</td>
            <td data-id="titulo">Título del Ejemplar</td>
            <td>
                <span class="badge" data-id="badgeTipo">LIBRO</span>
            </td>
            <td data-id="autor">Autor/Editor</td>
            <td data-id="ubicacion">Estante A-1</td>
            <td>
                <span data-id="disponibilidad" class="disponible">5/5</span>
            </td>
            <td data-id="anio">2024</td>
            <td>
                <div class="actions-cell">
                    <button class="btn-warning" data-id="btnEditar" onclick="editarEjemplar(1)"> Editar</button>
                    <button class="btn-danger" data-id="btnEliminar" onclick="eliminarEjemplar(1)"> Eliminar</button>
                    <button class="btn-primary" data-id="btnCantidades" onclick="gestionarCantidades(1)"> Cantidades</button>
                </div>
            </td>
        </tr>
    </template>

    <script>
        let ejemplares = [];
        let paginaActual = 1;
        const elementosPorPagina = 10;
        
        // Cargar ejemplares al iniciar
        document.addEventListener('DOMContentLoaded', function() {
            cargarEjemplares();
        });
        
        function cargarEjemplares() {
            // Simulación - luego se conectará con Java
            simularCargaEjemplares();
        }
        
        function simularCargaEjemplares() {
            // Datos de ejemplo - luego vendrán de Java
            ejemplares = [
                {
                    id: 1,
                    titulo: "Introducción a la Programación",
                    tipo: "LIBRO",
                    autor: "Juan Pérez",
                    ubicacion: "Estante A-15",
                    cantidadTotal: 5,
                    cantidadDisponible: 5,
                    anio: 2023
                },
                {
                    id: 2,
                    titulo: "Base de Datos Avanzadas", 
                    tipo: "LIBRO",
                    autor: "María González",
                    ubicacion: "Estante B-22",
                    cantidadTotal: 3,
                    cantidadDisponible: 2,
                    anio: 2024
                },
                {
                    id: 3,
                    titulo: "National Geographic",
                    tipo: "REVISTA", 
                    autor: "National Geographic Society",
                    ubicacion: "Estante R-05",
                    cantidadTotal: 10,
                    cantidadDisponible: 0,
                    anio: 2024
                },
                {
                    id: 4,
                    titulo: "Historia de la Música Clásica",
                    tipo: "CD",
                    autor: "Orquesta Sinfónica",
                    ubicacion: "Estante C-08", 
                    cantidadTotal: 3,
                    cantidadDisponible: 3,
                    anio: 2023
                },
                {
                    id: 5,
                    titulo: "Machine Learning en Educación",
                    tipo: "TESIS",
                    autor: "Ana Rodríguez",
                    ubicacion: "Estante T-12",
                    cantidadTotal: 1, 
                    cantidadDisponible: 1,
                    anio: 2024
                }
            ];
            
            mostrarEjemplares();
        }
        
        function mostrarEjemplares() {
            const tbody = document.getElementById('tbodyEjemplares');
            const template = document.getElementById('templateEjemplar');
            
            tbody.innerHTML = '';
            
            if (ejemplares.length === 0) {
                tbody.innerHTML = '<tr><td colspan="8" style="text-align: center; padding: 2rem;">No se encontraron ejemplares</td></tr>';
                return;
            }
            
            ejemplares.forEach(ejemplar => {
                const clone = template.content.cloneNode(true);
                
                // Llenar datos
                clone.querySelector('[data-id="id"]').textContent = ejemplar.id;
                clone.querySelector('[data-id="titulo"]').textContent = ejemplar.titulo;
                
                // Tipo con badge
                const badge = clone.querySelector('[data-id="badgeTipo"]');
                badge.textContent = ejemplar.tipo;
                badge.className = 'badge badge-' + ejemplar.tipo.toLowerCase();
                
                clone.querySelector('[data-id="autor"]').textContent = ejemplar.autor;
                clone.querySelector('[data-id="ubicacion"]').textContent = ejemplar.ubicacion;
                
                // Disponibilidad
                const disponibilidad = clone.querySelector('[data-id="disponibilidad"]');
                disponibilidad.textContent = `${ejemplar.cantidadDisponible}/${ejemplar.cantidadTotal}`;
                if (ejemplar.cantidadDisponible === 0) {
                    disponibilidad.className = 'agotado';
                } else {
                    disponibilidad.className = 'disponible';
                }
                
                clone.querySelector('[data-id="anio"]').textContent = ejemplar.anio;
                
                // Actualizar eventos
                clone.querySelector('[data-id="btnEditar"]').onclick = () => editarEjemplar(ejemplar.id);
                clone.querySelector('[data-id="btnEliminar"]').onclick = () => eliminarEjemplar(ejemplar.id);
                clone.querySelector('[data-id="btnCantidades"]').onclick = () => gestionarCantidades(ejemplar.id);
                
                tbody.appendChild(clone);
            });
            
            actualizarPaginacion();
        }
        
        function buscarEjemplares() {
            const termino = document.getElementById('searchInput').value.toLowerCase();
            // Aquí luego se filtrará desde Java
            alert('Buscando: ' + termino + ' - Esta funcionalidad se conectará con Java');
        }
        
        function filtrarEjemplares() {
            // Aquí luego se aplicarán filtros desde Java
            console.log('Filtrando ejemplares...');
        }
        
        function cambiarPagina(direccion) {
            paginaActual += direccion;
            mostrarEjemplares();
        }
        
        function actualizarPaginacion() {
            document.getElementById('infoPaginacion').textContent = 
                `Mostrando ${ejemplares.length} ejemplares`;
                
            document.getElementById('infoPaginaActual').textContent = 
                `Página ${paginaActual}`;
        }
        
        function editarEjemplar(id) {
            alert(`Editando ejemplar ID: ${id} - Esta funcionalidad se conectará con Java`);
        }
        
        function eliminarEjemplar(id) {
            if (confirm('¿Está seguro de eliminar este ejemplar?')) {
                alert(`Eliminando ejemplar ID: ${id} - Esta funcionalidad se conectará con Java`);
            }
        }
        
        function gestionarCantidades(id) {
            alert(`Gestionando cantidades del ejemplar ID: ${id} - Esta funcionalidad se conectará con Java`);
        }
    </script>
</body>
</html>