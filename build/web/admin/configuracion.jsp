<%-- 
    Document   : configuracion
    Created on : 11-28-2025, 10:56:16 PM
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
    <title>Configuración del Sistema - Biblioteca UDB</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <style>
        .config-container {
            padding: 2rem 0;
        }
        
        .config-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .config-section h2 {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #ecf0f1;
        }
        
        .config-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        .config-item {
            margin-bottom: 1.5rem;
        }
        
        .config-item label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: bold;
        }
        
        .config-item input, .config-item select {
            width: 100%;
            padding: 10px;
            border: 2px solid #bdc3c7;
            border-radius: 6px;
            font-size: 1rem;
        }
        
        .config-item input:focus, .config-item select:focus {
            outline: none;
            border-color: #3498db;
        }
        
        .help-text {
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-top: 0.25rem;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
            margin-right: 1rem;
        }
        
        .btn-secondary {
            background: #95a5a6;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
        }
        
        .btn-success {
            background: #27ae60;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
        }
        
        .actions-bar {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #ecf0f1;
        }
        
        .info-card {
            background: #e8f4fd;
            border-left: 4px solid #3498db;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
        }
        
        .current-settings {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 1rem;
        }
        
        .setting-item {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .setting-item:last-child {
            border-bottom: none;
        }
        
        .badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .badge-success { background: #27ae60; color: white; }
        .badge-warning { background: #f39c12; color: white; }
        
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
            <h1>⚙️ Configuración del Sistema</h1>
            <nav>
                <span><% out.print(session.getAttribute("usuarioNombre")); %> (Admin)</span>
                <a href="dashboard.jsp">Dashboard</a>
                <a href="gestion-ejemplares.jsp">Ejemplares</a>
                <a href="gestion-usuarios.jsp">Usuarios</a>
                <a href="gestion-prestamos.jsp">Préstamos</a>
                <a href="reportes.jsp">Reportes</a>
                <form action="../LogoutServlet" method="post" style="display: inline;">
                    <button type="submit" class="logout-btn">Cerrar Sesión</button>
                </form>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="config-container">
            <!-- Información actual -->
            <div class="config-section">
                <h2>📊 Configuración Actual del Sistema</h2>
                <div class="info-card">
                    <p><strong>💡 Información:</strong> Estas configuraciones afectan a todos los usuarios del sistema. Los cambios se aplican inmediatamente a nuevos préstamos.</p>
                </div>
                
                <div class="current-settings">
                    <h4>Valores Actuales:</h4>
                    <div class="setting-item">
                        <span>Límite de préstamos para Alumnos:</span>
                        <span class="badge badge-success" id="currentAlumnoLimit">3</span>
                    </div>
                    <div class="setting-item">
                        <span>Límite de préstamos para Profesores:</span>
                        <span class="badge badge-success" id="currentProfesorLimit">6</span>
                    </div>
                    <div class="setting-item">
                        <span>Días de préstamo para Alumnos:</span>
                        <span class="badge badge-warning" id="currentAlumnoDias">15</span>
                    </div>
                    <div class="setting-item">
                        <span>Días de préstamo para Profesores:</span>
                        <span class="badge badge-warning" id="currentProfesorDias">30</span>
                    </div>
                    <div class="setting-item">
                        <span>Mora diaria por retraso:</span>
                        <span class="badge badge-warning" id="currentMoraDiaria">$1.00</span>
                    </div>
                </div>
            </div>

            <!-- Formulario de configuración -->
            <div class="config-section">
                <h2>🔧 Modificar Configuración</h2>
                
                <form id="configForm">
                    <div class="config-grid">
                        <!-- Límites de préstamos -->
                        <div>
                            <h3>📚 Límites de Préstamos</h3>
                            
                            <div class="config-item">
                                <label for="limiteAlumnos">Límite para Alumnos:</label>
                                <input type="number" id="limiteAlumnos" name="limiteAlumnos" 
                                       min="1" max="10" value="3" required>
                                <div class="help-text">Número máximo de préstamos simultáneos para alumnos</div>
                            </div>
                            
                            <div class="config-item">
                                <label for="limiteProfesores">Límite para Profesores:</label>
                                <input type="number" id="limiteProfesores" name="limiteProfesores" 
                                       min="1" max="20" value="6" required>
                                <div class="help-text">Número máximo de préstamos simultáneos para profesores</div>
                            </div>
                        </div>
                        
                        <!-- Tiempos de préstamo -->
                        <div>
                            <h3>⏰ Tiempos de Préstamo</h3>
                            
                            <div class="config-item">
                                <label for="diasAlumnos">Días para Alumnos:</label>
                                <input type="number" id="diasAlumnos" name="diasAlumnos" 
                                       min="1" max="30" value="15" required>
                                <div class="help-text">Días de duración del préstamo para alumnos</div>
                            </div>
                            
                            <div class="config-item">
                                <label for="diasProfesores">Días para Profesores:</label>
                                <input type="number" id="diasProfesores" name="diasProfesores" 
                                       min="1" max="60" value="30" required>
                                <div class="help-text">Días de duración del préstamo para profesores</div>
                            </div>
                        </div>
                        
                        <!-- Configuración de moras -->
                        <div>
                            <h3>💰 Sistema de Moras</h3>
                            
                            <div class="config-item">
                                <label for="moraDiaria">Mora Diaria ($):</label>
                                <input type="number" id="moraDiaria" name="moraDiaria" 
                                       min="0.1" max="10" step="0.1" value="1.0" required>
                                <div class="help-text">Monto en dólares por cada día de retraso</div>
                            </div>
                            
                            <div class="config-item">
                                <label for="diasGracia">Días de Gracia:</label>
                                <input type="number" id="diasGracia" name="diasGracia" 
                                       min="0" max="5" value="0" required>
                                <div class="help-text">Días de gracia antes de aplicar mora (0 = inmediato)</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Acciones -->
                    <div class="actions-bar">
                        <button type="button" class="btn-secondary" onclick="restablecerValores()">
                            🔄 Restablecer Valores
                        </button>
                        <button type="submit" class="btn-success">
                            💾 Guardar Configuración
                        </button>
                    </div>
                </form>
            </div>

            <!-- Configuraciones adicionales -->
            <div class="config-section">
                <h2>🎛️ Configuraciones Adicionales</h2>
                
                <div class="config-grid">
                    <div>
                        <h3>📧 Notificaciones</h3>
                        
                        <div class="config-item">
                            <label>
                                <input type="checkbox" id="notifVencimiento" checked>
                                Notificar antes del vencimiento
                            </label>
                            <div class="help-text">Enviar recordatorio 2 días antes del vencimiento</div>
                        </div>
                        
                        <div class="config-item">
                            <label>
                                <input type="checkbox" id="notifMora" checked>
                                Notificar por mora
                            </label>
                            <div class="help-text">Enviar notificación cuando se genere mora</div>
                        </div>
                    </div>
                    
                    <div>
                        <h3>🔐 Seguridad</h3>
                        
                        <div class="config-item">
                            <label for="sessionTimeout">Tiempo de sesión (minutos):</label>
                            <input type="number" id="sessionTimeout" name="sessionTimeout" 
                                   min="15" max="480" value="120">
                            <div class="help-text">Tiempo de inactividad antes de cerrar sesión</div>
                        </div>
                        
                        <div class="config-item">
                            <label>
                                <input type="checkbox" id="requiereConfirmacion" checked>
                                Requerir confirmación para eliminaciones
                            </label>
                            <div class="help-text">Mostrar confirmación al eliminar registros</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Biblioteca Universidad Don Bosco - Configuración del Sistema</p>
        </div>
    </footer>

    <script>
        // Cargar configuración actual al iniciar
        document.addEventListener('DOMContentLoaded', function() {
            cargarConfiguracionActual();
        });
        
        // Manejar envío del formulario
        document.getElementById('configForm').addEventListener('submit', function(e) {
            e.preventDefault();
            guardarConfiguracion();
        });
        
        function cargarConfiguracionActual() {
            // Simulación - luego se cargará desde Java
            console.log('Cargando configuración actual...');
        }
        
        function guardarConfiguracion() {
            // Obtener valores del formulario
            const configuracion = {
                limiteAlumnos: document.getElementById('limiteAlumnos').value,
                limiteProfesores: document.getElementById('limiteProfesores').value,
                diasAlumnos: document.getElementById('diasAlumnos').value,
                diasProfesores: document.getElementById('diasProfesores').value,
                moraDiaria: document.getElementById('moraDiaria').value,
                diasGracia: document.getElementById('diasGracia').value,
                notifVencimiento: document.getElementById('notifVencimiento').checked,
                notifMora: document.getElementById('notifMora').checked,
                sessionTimeout: document.getElementById('sessionTimeout').value,
                requiereConfirmacion: document.getElementById('requiereConfirmacion').checked
            };
            
            // Validaciones
            if (parseInt(configuracion.limiteAlumnos) >= parseInt(configuracion.limiteProfesores)) {
                alert('Los profesores deben tener un límite mayor que los alumnos');
                return;
            }
            
            if (parseInt(configuracion.diasAlumnos) >= parseInt(configuracion.diasProfesores)) {
                alert('Los profesores deben tener más días de préstamo que los alumnos');
                return;
            }
            
            // Simular guardado
            console.log('Guardando configuración:', configuracion);
            
            // Actualizar vista de valores actuales
            actualizarVistaConfiguracion(configuracion);
            
            // Mostrar confirmación
            alert('✅ Configuración guardada exitosamente\n\nLos cambios se aplicarán a nuevos préstamos.');
        }
        
        function actualizarVistaConfiguracion(config) {
            document.getElementById('currentAlumnoLimit').textContent = config.limiteAlumnos;
            document.getElementById('currentProfesorLimit').textContent = config.limiteProfesores;
            document.getElementById('currentAlumnoDias').textContent = config.diasAlumnos;
            document.getElementById('currentProfesorDias').textContent = config.diasProfesores;
            document.getElementById('currentMoraDiaria').textContent = `$${parseFloat(config.moraDiaria).toFixed(2)}`;
        }
        
        function restablecerValores() {
            if (confirm('¿Restablecer todos los valores a los predeterminados?')) {
                document.getElementById('limiteAlumnos').value = 3;
                document.getElementById('limiteProfesores').value = 6;
                document.getElementById('diasAlumnos').value = 15;
                document.getElementById('diasProfesores').value = 30;
                document.getElementById('moraDiaria').value = 1.0;
                document.getElementById('diasGracia').value = 0;
                document.getElementById('notifVencimiento').checked = true;
                document.getElementById('notifMora').checked = true;
                document.getElementById('sessionTimeout').value = 120;
                document.getElementById('requiereConfirmacion').checked = true;
                
                alert('Valores restablecidos a los predeterminados');
            }
        }
        
        // Validaciones en tiempo real
        document.getElementById('limiteAlumnos').addEventListener('change', function() {
            const limiteProfesores = document.getElementById('limiteProfesores');
            if (parseInt(this.value) >= parseInt(limiteProfesores.value)) {
                limiteProfesores.value = parseInt(this.value) + 1;
            }
        });
        
        document.getElementById('diasAlumnos').addEventListener('change', function() {
            const diasProfesores = document.getElementById('diasProfesores');
            if (parseInt(this.value) >= parseInt(diasProfesores.value)) {
                diasProfesores.value = parseInt(this.value) + 5;
            }
        });
    </script>
</body>
</html>