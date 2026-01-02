<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Plataforma Educativa - LUMEN</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
    --primary: #FF6B35; /* Naranja corporativo */
    --secondary: #003366; /* Azul rey */
    --accent: #4A90E2; /* Azul claro */
    --light: #f8f9fa;
    --dark: #333;
    --gray: #6c757d;
    --success: #28a745;
    --bg: #f0f4f8;
    --sidebar-width: 250px;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    background: var(--bg);
    color: var(--dark);
    overflow-x: hidden;
}

/* ===== LAYOUT PRINCIPAL ===== */
#main-app {
    display: block;
}

/* Sidebar */
.sidebar {
    position: fixed;
    left: 0;
    top: 0;
    width: var(--sidebar-width);
    height: 100vh;
    background: var(--secondary);
    color: white;
    padding: 20px 0;
    z-index: 100;
    transform: translateX(0);
    transition: transform 0.3s ease;
}

.user-info {
    text-align: center;
    padding: 20px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    margin-bottom: 20px;
}

.user-avatar {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background: var(--primary);
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 15px;
    font-size: 2rem;
}

.sidebar-nav {
    list-style: none;
}

.sidebar-nav li {
    margin-bottom: 5px;
}

.sidebar-nav a {
    display: flex;
    align-items: center;
    padding: 15px 25px;
    color: rgba(255, 255, 255, 0.8);
    text-decoration: none;
    transition: all 0.3s;
    border-left: 4px solid transparent;
}

.sidebar-nav a:hover, .sidebar-nav a.active {
    background: rgba(255, 255, 255, 0.1);
    color: white;
    border-left-color: var(--primary);
}

.sidebar-nav i {
    margin-right: 12px;
    width: 20px;
    text-align: center;
}

/* Top Nav */
.top-nav {
    position: fixed;
    top: 0;
    left: var(--sidebar-width);
    right: 0;
    background: white;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    z-index: 99;
}

.nav-buttons {
    display: flex;
    gap: 15px;
}

.nav-buttons button {
    background: none;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    font-weight: 600;
    color: var(--gray);
    border-bottom: 3px solid transparent;
    transition: all 0.3s;
}

.nav-buttons button.active {
    color: var(--primary);
    border-bottom-color: var(--primary);
}

.user-controls {
    display: flex;
    align-items: center;
    gap: 20px;
}

.progress-global {
    background: var(--light);
    border-radius: 20px;
    height: 10px;
    width: 150px;
    overflow: hidden;
}

.progress-bar {
    height: 100%;
    background: linear-gradient(90deg, var(--primary), var(--accent));
    border-radius: 20px;
    transition: width 0.5s ease;
}

.logout-btn {
    background: var(--light);
    border: none;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s;
}

.logout-btn:hover {
    background: var(--primary);
    color: white;
}

/* Main Content */
.main-content {
    margin-left: var(--sidebar-width);
    margin-top: 70px;
    padding: 30px;
    min-height: calc(100vh - 70px);
}

.section {
    display: none;
    animation: fadeIn 0.5s ease;
}

.section.active {
    display: block;
}

/* ===== DASHBOARD ===== */
.welcome-banner {
    background: linear-gradient(135deg, var(--secondary), var(--accent));
    color: white;
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: white;
    border-radius: 15px;
    padding: 25px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    border-top: 5px solid var(--primary);
}

.stat-card i {
    font-size: 2.5rem;
    color: var(--primary);
    margin-bottom: 15px;
}

.stat-card h3 {
    font-size: 2rem;
    color: var(--secondary);
}

.materias-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 25px;
}

.materia-card {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    transition: transform 0.3s, box-shadow 0.3s;
}

.materia-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
}

.materia-header {
    padding: 20px;
    color: white;
    display: flex;
    align-items: center;
    gap: 15px;
}

.materia-header i {
    font-size: 2rem;
}

.matematicas .materia-header { background: #FF6B35; }
.lectura .materia-header { background: #4A90E2; }
.ciencias .materia-header { background: #28a745; }
.sociales .materia-header { background: #6f42c1; }
.ingles .materia-header { background: #17a2b8; }

.materia-content {
    padding: 20px;
}

.progress-info {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
}

.progress {
    height: 10px;
    background: #e9ecef;
    border-radius: 5px;
    overflow: hidden;
    margin: 15px 0;
}

.progress-fill {
    height: 100%;
    background: linear-gradient(90deg, var(--primary), var(--accent));
    border-radius: 5px;
    transition: width 0.5s ease;
}

/* ===== CURSO DETALLE ===== */
.back-btn {
    background: none;
    border: none;
    color: var(--primary);
    font-size: 1rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 20px;
    padding: 10px 0;
}

.video-container {
    background: #000;
    border-radius: 15px;
    overflow: hidden;
    margin-bottom: 30px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}

.video-container iframe {
    width: 100%;
    height: 500px;
    display: block;
}

.clases-container {
    background: white;
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.clase-item {
    display: flex;
    align-items: center;
    padding: 15px;
    border-bottom: 1px solid #eee;
    cursor: pointer;
    transition: background 0.3s;
}

.clase-item:hover {
    background: var(--light);
}

.clase-item.completed {
    background: #f0fff4;
}

.checkbox-custom {
    width: 24px;
    height: 24px;
    border: 2px solid #ddd;
    border-radius: 50%;
    margin-right: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    flex-shrink: 0;
    transition: all 0.3s;
}

.checkbox-custom.checked {
    background: var(--success);
    border-color: var(--success);
    color: white;
}

.clase-info {
    flex: 1;
}

.clase-info h4 {
    margin-bottom: 5px;
}

.clase-meta {
    display: flex;
    gap: 15px;
    color: var(--gray);
    font-size: 0.9rem;
}

/* ===== SIMULACROS ===== */
.simulacros-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
    gap: 30px;
}

.simulacro-card {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.simulacro-header {
    background: linear-gradient(135deg, var(--secondary), var(--accent));
    color: white;
    padding: 25px;
    text-align: center;
}

.simulacro-content {
    padding: 25px;
}

.horarios {
    background: var(--light);
    border-radius: 10px;
    padding: 20px;
    margin: 20px 0;
}

.horario-item {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    border-bottom: 1px solid #dee2e6;
}

.horario-item:last-child {
    border-bottom: none;
}

.btn {
    background: var(--primary);
    color: white;
    border: none;
    padding: 15px 30px;
    border-radius: 10px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
    width: 100%;
    margin-top: 10px;
}

.btn:hover {
    background: #e55a2b;
    transform: translateY(-2px);
    box-shadow: 0 7px 14px rgba(255, 107, 53, 0.3);
}

.btn-secondary {
    background: var(--secondary);
}

.btn-secondary:hover {
    background: #002244;
}

.btn-disabled {
    background: #ccc;
    cursor: not-allowed;
}

.btn-disabled:hover {
    transform: none;
    box-shadow: none;
    background: #ccc;
}

/* ===== RESPONSIVE ===== */
@media (max-width: 992px) {
    .sidebar {
        transform: translateX(-100%);
    }
    
    .sidebar.active {
        transform: translateX(0);
    }
    
    .top-nav {
        left: 0;
    }
    
    .main-content {
        margin-left: 0;
    }
    
    .menu-toggle {
        display: block !important;
    }
}

.menu-toggle {
    display: none;
    background: none;
    border: none;
    font-size: 1.5rem;
    color: var(--secondary);
    cursor: pointer;
}

/* ===== ANIMATIONS ===== */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

.pulse {
    animation: pulse 2s infinite;
}

.status {
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 600;
}

.status.pending {
    background: #fff3cd;
    color: #856404;
}

.status.locked {
    background: #e2e3e5;
    color: #383d41;
}

.status.completed {
    background: #d4edda;
    color: #155724;
}
</style>
</head>
<body>

<!-- ===== MAIN APPLICATION ===== -->
<div id="main-app">
    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <div class="user-info">
            <div class="user-avatar">
                <i class="fas fa-user-graduate"></i>
            </div>
            <h3 id="current-user">Estudiante LUMEN</h3>
            <p id="user-email">Bienvenido/a a la plataforma</p>
        </div>
        
        <ul class="sidebar-nav">
            <li><a href="#" class="active" onclick="showSection('dashboard')"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="#" onclick="showSection('cursos')"><i class="fas fa-book-open"></i> Mis Cursos</a></li>
            <li><a href="#" onclick="showSection('simulacros')"><i class="fas fa-clipboard-list"></i> Simulacros</a></li>
            <li><a href="#" onclick="showSection('progreso')"><i class="fas fa-chart-line"></i> Mi Progreso</a></li>
            <li><a href="#" onclick="showSection('recursos')"><i class="fas fa-folder-open"></i> Recursos</a></li>
        </ul>
        
        <div style="position: absolute; bottom: 20px; width: 100%; text-align: center; color: rgba(255,255,255,0.5); font-size: 0.8rem;">
            <p>© 2024 LUMEN Educativo</p>
        </div>
    </aside>
    
    <!-- Top Navigation -->
    <nav class="top-nav">
        <button class="menu-toggle" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
        
        <div class="nav-buttons">
            <button class="active" onclick="showNavSection('cursos')">📚 Cursos</button>
            <button onclick="showNavSection('simulacros')">📝 Simulacros</button>
        </div>
        
        <div class="user-controls">
            <div style="text-align: right; margin-right: 15px;">
                <small>Progreso Global</small>
                <div class="progress-global">
                    <div class="progress-bar" id="global-progress-bar"></div>
                </div>
            </div>
            <button class="logout-btn" onclick="resetProgress()" title="Reiniciar progreso">
                <i class="fas fa-redo"></i>
            </button>
        </div>
    </nav>
    
    <!-- Main Content -->
    <main class="main-content">
        <!-- Dashboard -->
        <section id="dashboard" class="section active">
            <div class="welcome-banner">
                <h1 id="welcome-message">¡Bienvenido a LUMEN Educativo!</h1>
                <p>Prepara tu ICFES con nuestra plataforma. Tienes <span id="pending-classes">40</span> clases disponibles.</p>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-check-circle"></i>
                    <h3 id="completed-classes">0</h3>
                    <p>Clases Completadas</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-clock"></i>
                    <h3 id="total-hours">0</h3>
                    <p>Horas de Estudio</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-chart-bar"></i>
                    <h3 id="global-percentage">0%</h3>
                    <p>Progreso Global</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-calendar-alt"></i>
                    <h3 id="days-left">30</h3>
                    <p>Días Restantes</p>
                </div>
            </div>
            
            <h2 style="margin-bottom: 20px; color: var(--secondary);">Mis Materias ICFES</h2>
            <div class="materias-grid" id="materias-container">
                <!-- Las materias se cargarán dinámicamente -->
            </div>
        </section>
        
        <!-- Cursos -->
        <section id="cursos" class="section">
            <h1 style="color: var(--secondary); margin-bottom: 30px;">Mis Cursos ICFES</h1>
            <div class="materias-grid" id="cursos-container">
                <!-- Cursos se cargarán aquí -->
            </div>
        </section>
        
        <!-- Curso Detalle -->
        <section id="curso-detalle" class="section">
            <!-- Se carga dinámicamente -->
        </section>
        
        <!-- Simulacros -->
        <section id="simulacros" class="section">
            <h1 style="color: var(--secondary); margin-bottom: 30px;">Simulacros Programados</h1>
            <div class="simulacros-grid">
                <!-- Simulacro 1 -->
                <div class="simulacro-card">
                    <div class="simulacro-header">
                        <h2><i class="fas fa-clipboard-check"></i> Simulacro Diagnóstico #1</h2>
                        <p>Fecha: 15 de Noviembre, 2024</p>
                    </div>
                    <div class="simulacro-content">
                        <p>Este simulacro te permitirá evaluar tu nivel actual en todas las áreas del ICFES.</p>
                        
                        <div class="horarios">
                            <h4><i class="fas fa-clock"></i> Horarios</h4>
                            <div class="horario-item">
                                <span>Primera Sesión:</span>
                                <strong>7:00 AM - 11:30 AM</strong>
                            </div>
                            <div class="horario-item">
                                <span>Segunda Sesión:</span>
                                <strong>1:30 PM - 6:00 PM</strong>
                            </div>
                        </div>
                        
                        <div class="progress-info">
                            <span>Estado:</span>
                            <span class="status pending">Pendiente</span>
                        </div>
                        
                        <button class="btn btn-secondary" style="margin-top: 20px;">
                            <i class="fas fa-play-circle"></i> Iniciar Simulacro
                        </button>
                    </div>
                </div>
                
                <!-- Simulacro 2 -->
                <div class="simulacro-card">
                    <div class="simulacro-header">
                        <h2><i class="fas fa-chart-line"></i> Simulacro Final #2</h2>
                        <p>Fecha: 10 de Diciembre, 2024</p>
                    </div>
                    <div class="simulacro-content">
                        <p>Simulacro final para evaluar tu progreso después del curso intensivo.</p>
                        
                        <div class="horarios">
                            <h4><i class="fas fa-clock"></i> Horarios</h4>
                            <div class="horario-item">
                                <span>Primera Sesión:</span>
                                <strong>7:00 AM - 11:30 AM</strong>
                            </div>
                            <div class="horario-item">
                                <span>Segunda Sesión:</span>
                                <strong>1:30 PM - 6:00 PM</strong>
                            </div>
                        </div>
                        
                        <div class="progress-info">
                            <span>Estado:</span>
                            <span class="status locked">Bloqueado</span>
                        </div>
                        
                        <button class="btn btn-disabled" style="margin-top: 20px;" disabled>
                            <i class="fas fa-lock"></i> Disponible desde el 1/12/2024
                        </button>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Progreso -->
        <section id="progreso" class="section">
            <h1 style="color: var(--secondary); margin-bottom: 30px;">Mi Progreso</h1>
            <div style="background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                <h3 style="margin-bottom: 20px;">Progreso por Materia</h3>
                <div id="progress-details">
                    <!-- Detalles de progreso se cargarán aquí -->
                </div>
            </div>
        </section>
        
        <!-- Recursos -->
        <section id="recursos" class="section">
            <h1 style="color: var(--secondary); margin-bottom: 30px;">Recursos Adicionales</h1>
            <div style="background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                <div class="grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px;">
                    <div class="card" style="background: #f8f9fa; padding: 20px; border-radius: 10px;">
                        <i class="fas fa-file-pdf" style="font-size: 2rem; color: var(--primary); margin-bottom: 15px;"></i>
                        <h4>Guías de Estudio</h4>
                        <p>Material complementario en PDF</p>
                    </div>
                    <div class="card" style="background: #f8f9fa; padding: 20px; border-radius: 10px;">
                        <i class="fas fa-video" style="font-size: 2rem; color: var(--primary); margin-bottom: 15px;"></i>
                        <h4>Clases Extra</h4>
                        <p>Contenido adicional grabado</p>
                    </div>
                    <div class="card" style="background: #f8f9fa; padding: 20px; border-radius: 10px;">
                        <i class="fas fa-question-circle" style="font-size: 2rem; color: var(--primary); margin-bottom: 15px;"></i>
                        <h4>FAQ ICFES</h4>
                        <p>Preguntas frecuentes</p>
                    </div>
                </div>
            </div>
        </section>
    </main>
</div>

<script>
// ===== DATOS DE LA PLATAFORMA =====
const materias = [
    {
        id: "matematicas",
        nombre: "Matemáticas",
        icono: "fas fa-calculator",
        color: "#FF6B35",
        totalClases: 8,
        clases: [
            {id: "mat-1", titulo: "Álgebra Básica", duracion: "45 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "mat-2", titulo: "Geometría Euclidiana", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "mat-3", titulo: "Funciones y Gráficas", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "mat-4", titulo: "Probabilidad y Estadística", duracion: "60 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "mat-5", titulo: "Trigonometría", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "mat-6", titulo: "Cálculo Diferencial", duracion: "65 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "mat-7", titulo: "Números Complejos", duracion: "45 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "mat-8", titulo: "Lógica Matemática", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"}
        ]
    },
    {
        id: "lectura",
        nombre: "Lectura Crítica",
        icono: "fas fa-book-reader",
        color: "#4A90E2",
        totalClases: 8,
        clases: [
            {id: "lec-1", titulo: "Comprensión Lectora", duracion: "40 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "lec-2", titulo: "Análisis de Textos", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "lec-3", titulo: "Inferencia y Deducción", duracion: "45 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "lec-4", titulo: "Coherencia y Cohesión", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "lec-5", titulo: "Tipos de Textos", duracion: "60 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "lec-6", titulo: "Estrategias de Lectura", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "lec-7", titulo: "Lectura Crítica Avanzada", duracion: "65 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "lec-8", titulo: "Análisis de Argumentos", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"}
        ]
    },
    {
        id: "ciencias",
        nombre: "Ciencias Naturales",
        icono: "fas fa-flask",
        color: "#28a745",
        totalClases: 8,
        clases: [
            {id: "cien-1", titulo: "Biología Celular", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "cien-2", titulo: "Física Mecánica", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "cien-3", titulo: "Química Orgánica", duracion: "60 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "cien-4", titulo: "Ecología y Medio Ambiente", duracion: "45 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "cien-5", titulo: "Genética y Herencia", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "cien-6", titulo: "Termodinámica", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "cien-7", titulo: "Evolución y Biodiversidad", duracion: "60 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "cien-8", titulo: "Energía y Ondas", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"}
        ]
    },
    {
        id: "sociales",
        nombre: "Sociales y Ciudadanas",
        icono: "fas fa-globe-americas",
        color: "#6f42c1",
        totalClases: 8,
        clases: [
            {id: "soc-1", titulo: "Historia de Colombia", duracion: "60 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "soc-2", titulo: "Geografía Mundial", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "soc-3", titulo: "Constitución Política", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "soc-4", titulo: "Economía Básica", duracion: "45 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "soc-5", titulo: "Derechos Humanos", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "soc-6", titulo: "Cultura y Sociedad", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "soc-7", titulo: "Sistema Político", duracion: "60 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "soc-8", titulo: "Problemas Sociales Contemporáneos", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"}
        ]
    },
    {
        id: "ingles",
        nombre: "Inglés",
        icono: "fas fa-language",
        color: "#17a2b8",
        totalClases: 8,
        clases: [
            {id: "ing-1", titulo: "Gramática Básica", duracion: "45 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "ing-2", titulo: "Vocabulario Esencial", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "ing-3", titulo: "Comprensión Auditiva", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "ing-4", titulo: "Lectura en Inglés", duracion: "60 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "ing-5", titulo: "Expresión Escrita", duracion: "50 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "ing-6", titulo: "Phrasal Verbs", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "ing-7", titulo: "Pronunciación", duracion: "60 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"},
            {id: "ing-8", titulo: "Práctica de Examen", duracion: "55 min", video: "https://www.youtube.com/embed/dQw4w9WgXcQ"}
        ]
    }
];

// ===== VARIABLES GLOBALES =====
let progreso = {};
let currentVideo = "https://www.youtube.com/embed/dQw4w9WgXcQ";
let currentVideoTitle = "Introducción al Curso";

// ===== FUNCIONES PRINCIPALES =====
function init() {
    loadProgress();
    renderDashboard();
    renderCursos();
    updateStats();
    updateGlobalProgress();
}

function loadProgress() {
    const saved = localStorage.getItem('lumenProgress');
    if (saved) {
        progreso = JSON.parse(saved);
    } else {
        // Inicializar progreso vacío
        materias.forEach(materia => {
            progreso[materia.id] = {
                completadas: 0,
                clases: {}
            };
        });
        saveProgress();
    }
}

function saveProgress() {
    localStorage.setItem('lumenProgress', JSON.stringify(progreso));
}

function toggleClase(materiaId, claseId) {
    if (!progreso[materiaId]) {
        progreso[materiaId] = { completadas: 0, clases: {} };
    }
    
    if (progreso[materiaId].clases[claseId]) {
        // Desmarcar
        delete progreso[materiaId].clases[claseId];
        progreso[materiaId].completadas--;
    } else {
        // Marcar como completada
        progreso[materiaId].clases[claseId] = true;
        progreso[materiaId].completadas++;
    }
    
    saveProgress();
    updateStats();
    updateGlobalProgress();
    
    // Si estamos en el detalle del curso, actualizar la vista
    if (document.getElementById('curso-detalle').classList.contains('active')) {
        const materia = materias.find(m => m.id === materiaId);
        renderCursoDetalle(materia);
    }
}

function updateStats() {
    let totalCompletadas = 0;
    let totalHoras = 0;
    let totalClases = 0;
    
    materias.forEach(materia => {
        const progress = progreso[materia.id] || { completadas: 0 };
        totalCompletadas += progress.completadas;
        totalClases += materia.totalClases;
        
        // Calcular horas aproximadas (45 min por clase en promedio)
        totalHoras += Math.round(progress.completadas * 0.75);
    });
    
    const totalPendientes = totalClases - totalCompletadas;
    const porcentajeGlobal = totalClases > 0 ? Math.round((totalCompletadas / totalClases) * 100) : 0;
    
    // Actualizar DOM
    document.getElementById('completed-classes').textContent = totalCompletadas;
    document.getElementById('pending-classes').textContent = totalPendientes;
    document.getElementById('total-hours').textContent = totalHoras;
    document.getElementById('global-percentage').textContent = `${porcentajeGlobal}%`;
    document.getElementById('global-progress-bar').style.width = `${porcentajeGlobal}%`;
}

function updateGlobalProgress() {
    let totalCompletadas = 0;
    let totalClases = 0;
    
    materias.forEach(materia => {
        const progress = progreso[materia.id] || { completadas: 0 };
        totalCompletadas += progress.completadas;
        totalClases += materia.totalClases;
    });
    
    const porcentaje = totalClases > 0 ? Math.round((totalCompletadas / totalClases) * 100) : 0;
    document.getElementById('global-progress-bar').style.width = `${porcentaje}%`;
}

// ===== RENDER FUNCTIONS =====
function renderDashboard() {
    const container = document.getElementById('materias-container');
    container.innerHTML = '';
    
    materias.forEach(materia => {
        const progress = progreso[materia.id] || { completadas: 0 };
        const porcentaje = Math.round((progress.completadas / materia.totalClases) * 100);
        
        const card = document.createElement('div');
        card.className = `materia-card ${materia.id}`;
        card.innerHTML = `
            <div class="materia-header">
                <i class="${materia.icono}"></i>
                <h3>${materia.nombre}</h3>
            </div>
            <div class="materia-content">
                <div class="progress-info">
                    <span>Progreso</span>
                    <span>${progress.completadas}/${materia.totalClases} clases</span>
                </div>
                <div class="progress">
                    <div class="progress-fill" style="width: ${porcentaje}%"></div>
                </div>
                <button class="btn" onclick="openCurso('${materia.id}')" style="padding: 10px 20px;">
                    <i class="fas fa-play-circle"></i> Continuar Estudiando
                </button>
            </div>
        `;
        container.appendChild(card);
    });
}

function renderCursos() {
    const container = document.getElementById('cursos-container');
    container.innerHTML = '';
    
    materias.forEach(materia => {
        const progress = progreso[materia.id] || { completadas: 0 };
        const porcentaje = Math.round((progress.completadas / materia.totalClases) * 100);
        
        const card = document.createElement('div');
        card.className = `materia-card ${materia.id}`;
        card.innerHTML = `
            <div class="materia-header">
                <i class="${materia.icono}"></i>
                <h3>${materia.nombre}</h3>
            </div>
            <div class="materia-content">
                <p>${materia.totalClases} clases grabadas disponibles</p>
                <div class="progress-info">
                    <span>Progreso</span>
                    <span>${porcentaje}%</span>
                </div>
                <div class="progress">
                    <div class="progress-fill" style="width: ${porcentaje}%"></div>
                </div>
                <button class="btn" onclick="openCurso('${materia.id}')" style="padding: 10px 20px;">
                    <i class="fas fa-play"></i> Ver Clases
                </button>
            </div>
        `;
        container.appendChild(card);
    });
}

function renderCursoDetalle(materia) {
    const container = document.getElementById('curso-detalle');
    const progress = progreso[materia.id] || { completadas: 0, clases: {} };
    
    container.innerHTML = `
        <button class="back-btn" onclick="showSection('cursos')">
            <i class="fas fa-arrow-left"></i> Volver a Cursos
        </button>
        
        <h1 style="color: var(--secondary); margin-bottom: 20px;">
            <i class="${materia.icono}"></i> ${materia.nombre}
        </h1>
        
        <div class="video-container">
            <iframe src="${currentVideo}" frameborder="0" 
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                    allowfullscreen>
            </iframe>
        </div>
        
        <div style="background: white; padding: 20px; border-radius: 10px; margin-bottom: 30px;">
            <h3 style="color: var(--secondary); margin-bottom: 10px;">${currentVideoTitle}</h3>
            <p>Clase actual en reproducción. Marca las clases como completadas a medida que las termines.</p>
        </div>
        
        <div class="clases-container">
            <h3 style="color: var(--secondary); margin-bottom: 20px;">
                <i class="fas fa-play-circle"></i> Clases Grabadas (${materia.totalClases} clases)
            </h3>
            
            ${materia.clases.map((clase, index) => `
                <div class="clase-item ${progress.clases[clase.id] ? 'completed' : ''}" 
                     onclick="playVideo('${clase.video}', '${clase.titulo}')">
                    <div class="checkbox-custom ${progress.clases[clase.id] ? 'checked' : ''}" 
                         onclick="event.stopPropagation(); toggleClase('${materia.id}', '${clase.id}')">
                        ${progress.clases[clase.id] ? '<i class="fas fa-check"></i>' : ''}
                    </div>
                    <div class="clase-info">
                        <h4>${index + 1}. ${clase.titulo}</h4>
                        <div class="clase-meta">
                            <span><i class="far fa-clock"></i> ${clase.duracion}</span>
                            <span>${progress.clases[clase.id] ? '<i class="fas fa-check-circle" style="color: #28a745;"></i> Completada' : '<i class="far fa-circle" style="color: #ccc;"></i> Pendiente'}</span>
                        </div>
                    </div>
                    <i class="fas fa-play-circle" style="color: var(--primary); font-size: 1.2rem;"></i>
                </div>
            `).join('')}
        </div>
    `;
    
    showSection('curso-detalle');
}

function renderProgreso() {
    const container = document.getElementById('progress-details');
    let html = '<div style="display: grid; gap: 20px;">';
    
    materias.forEach(materia => {
        const progress = progreso[materia.id] || { completadas: 0 };
        const porcentaje = Math.round((progress.completadas / materia.totalClases) * 100);
        
        html += `
            <div style="background: #f8f9fa; padding: 20px; border-radius: 10px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                    <h4 style="color: var(--secondary);">
                        <i class="${materia.icono}"></i> ${materia.nombre}
                    </h4>
                    <span style="font-weight: bold; color: var(--primary);">${porcentaje}%</span>
                </div>
                <div class="progress" style="height: 12px;">
                    <div class="progress-fill" style="width: ${porcentaje}%;"></div>
                </div>
                <div style="display: flex; justify-content: space-between; margin-top: 10px; font-size: 0.9rem;">
                    <span>${progress.completadas} de ${materia.totalClases} clases</span>
                    <span>${materia.totalClases - progress.completadas} pendientes</span>
                </div>
            </div>
        `;
    });
    
    html += '</div>';
    container.innerHTML = html;
}

// ===== NAVEGACIÓN =====
function showSection(sectionId) {
    // Ocultar todas las secciones
    document.querySelectorAll('.section').forEach(section => {
        section.classList.remove('active');
    });
    
    // Remover active de todos los enlaces del sidebar
    document.querySelectorAll('.sidebar-nav a').forEach(link => {
        link.classList.remove('active');
    });
    
    // Activar la sección solicitada
    const section = document.getElementById(sectionId);
    if (section) {
        section.classList.add('active');
        
        // Activar el enlace correspondiente en el sidebar
        const link = document.querySelector(`.sidebar-nav a[onclick*="${sectionId}"]`);
        if (link) link.classList.add('active');
        
        // Si es la sección de progreso, renderizar
        if (sectionId === 'progreso') {
            renderProgreso();
        }
    }
}

function showNavSection(sectionId) {
    showSection(sectionId);
    
    // Actualizar botones del nav superior
    document.querySelectorAll('.nav-buttons button').forEach(btn => {
        btn.classList.remove('active');
    });
    event.target.classList.add('active');
}

function openCurso(materiaId) {
    const materia = materias.find(m => m.id === materiaId);
    if (materia) {
        currentVideo = materia.clases[0].video;
        currentVideoTitle = materia.clases[0].titulo;
        renderCursoDetalle(materia);
    }
}

function playVideo(videoUrl, title) {
    currentVideo = videoUrl;
    currentVideoTitle = title;
    
    // Actualizar el video en el curso detalle
    const iframe = document.querySelector('.video-container iframe');
    if (iframe) {
        iframe.src = videoUrl;
    }
    
    // Actualizar el título
    const titleElement = document.querySelector('.clases-container + div h3');
    if (titleElement) {
        titleElement.textContent = title;
    }
}

function toggleSidebar() {
    document.getElementById('sidebar').classList.toggle('active');
}

function resetProgress() {
    if (confirm('¿Estás seguro de que quieres reiniciar todo tu progreso? Se perderán todas las clases marcadas como completadas.')) {
        // Reiniciar progreso
        materias.forEach(materia => {
            progreso[materia.id] = {
                completadas: 0,
                clases: {}
            };
        });
        
        saveProgress();
        updateStats();
        updateGlobalProgress();
        renderDashboard();
        renderCursos();
        
        alert('¡Progreso reiniciado! Puedes comenzar de nuevo.');
    }
}

// ===== INICIALIZACIÓN =====
document.addEventListener('DOMContentLoaded', function() {
    init();
    
    // Mostrar dashboard por defecto
    showSection('dashboard');
});
</script>
</body>
</html>
