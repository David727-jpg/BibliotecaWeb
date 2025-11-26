

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Biblioteca UDB</title>
    <link rel="stylesheet" href="css/estilos.css">
    <style>
        .login-container {
            max-width: 400px;
            margin: 4rem auto;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .login-container h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 2rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: bold;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 2px solid #bdc3c7;
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #3498db;
        }
        
        .btn-login {
            width: 100%;
            padding: 12px;
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-login:hover {
            background: #219a52;
        }
        
        .back-link {
            text-align: center;
            margin-top: 1.5rem;
        }
        
        .back-link a {
            color: #3498db;
            text-decoration: none;
        }
        
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1> Biblioteca Universidad Don Bosco</h1>
            <nav>
                <a href="publico/index.html">Catálogo Público</a>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="login-container">
            <h2> Ingresar al Sistema</h2>
            
            <form action="LoginServlet" method="POST">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" placeholder="usuario@udb.edu" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" name="password" placeholder="Ingrese su contraseña" required>
                </div>
                
                <div class="form-group">
                    <label for="tipoUsuario">Tipo de Usuario:</label>
                    <select id="tipoUsuario" name="tipoUsuario" required>
                        <option value="">Seleccionar...</option>
                        <option value="ALUMNO">Alumno</option>
                        <option value="PROFESOR">Profesor</option>
                        <option value="ADMINISTRADOR">Administrador</option>
                    </select>
                </div>
                
                <button type="submit" class="btn-login">Ingresar al Sistema</button>
            </form>
            
            <div class="back-link">
                <a href="publico/index.html">← Volver al catálogo público</a>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Biblioteca Universidad Don Bosco. Todos los derechos reservados.</p>
        </div>
    </footer>
</body>
</html>