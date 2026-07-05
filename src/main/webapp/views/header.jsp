<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${param.titulo}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        @keyframes shimmer {
            0% { background-position: -200% 0; }
            100% { background-position: 200% 0; }
        }
        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        body {
            background: linear-gradient(135deg, #f8f9fc 0%, #e8ecf4 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        .navbar {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%) !important;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            animation: slideDown 0.6s ease-out;
        }
        .navbar-brand {
            font-weight: 800;
            letter-spacing: 1px;
            font-size: 1.4rem;
            transition: transform 0.3s;
        }
        .navbar-brand:hover {
            transform: scale(1.05);
        }
        .navbar-brand i {
            color: #e94560;
        }
        .nav-link {
            position: relative;
            transition: all 0.3s;
            border-radius: 8px;
            margin: 0 2px;
        }
        .nav-link:hover {
            background: rgba(255,255,255,0.1);
            transform: translateY(-2px);
        }
        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 2px;
            left: 50%;
            width: 0;
            height: 2px;
            background: #e94560;
            transition: all 0.3s;
            transform: translateX(-50%);
        }
        .nav-link:hover::after {
            width: 60%;
        }

        .card {
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.06);
            border: none;
            animation: fadeInUp 0.5s ease-out;
            transition: transform 0.3s, box-shadow 0.3s;
            overflow: hidden;
        }
        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 40px rgba(0,0,0,0.1);
        }
        .card-header {
            border-radius: 16px 16px 0 0 !important;
            font-weight: 700;
            font-size: 1.1rem;
            letter-spacing: 0.3px;
            border-bottom: none;
            background: linear-gradient(135deg, #1a1a2e, #0f3460) !important;
        }
        .card-header.bg-primary {
            background: linear-gradient(135deg, #0f3460, #533483) !important;
        }
        .card-header.bg-success {
            background: linear-gradient(135deg, #11998e, #38ef7d) !important;
        }
        .card-header.bg-warning {
            background: linear-gradient(135deg, #f2994a, #f2c94c) !important;
        }
        .card-header.bg-dark {
            background: linear-gradient(135deg, #1a1a2e, #16213e) !important;
        }

        .table th {
            font-weight: 700;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            border-bottom: 2px solid rgba(255,255,255,0.1);
        }
        .table tbody tr {
            transition: all 0.3s;
            animation: fadeIn 0.4s ease-out;
        }
        .table tbody tr:hover {
            background: rgba(13, 110, 253, 0.04);
            transform: scale(1.003);
        }
        .table tbody tr td:first-child {
            font-weight: 600;
            color: #6c757d;
        }

        .badge-clasificacion {
            font-size: 0.8rem;
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: transform 0.3s;
        }
        .badge-clasificacion:hover {
            transform: scale(1.1);
        }

        .btn {
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        .btn-sm {
            border-radius: 6px;
            padding: 6px 12px;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .btn:active {
            transform: translateY(0);
        }
        .btn-outline-warning:hover, .btn-outline-danger:hover {
            transform: translateY(-2px) scale(1.05);
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            padding: 10px 16px;
            transition: all 0.3s;
            font-size: 0.95rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: #0f3460;
            box-shadow: 0 0 0 4px rgba(15, 52, 96, 0.1);
            transform: translateY(-1px);
        }
        .form-control:hover, .form-select:hover {
            border-color: #b0b0b0;
        }
        .form-label {
            font-weight: 600;
            color: #2d3436;
            font-size: 0.9rem;
            margin-bottom: 6px;
        }

        footer {
            font-size: 0.85rem;
            color: #6c757d;
            animation: fadeIn 0.8s ease-out;
        }
        footer hr {
            opacity: 0.15;
        }

        .toast-container {
            z-index: 1080;
        }
        .toast {
            animation: slideDown 0.4s ease-out;
            border: none;
            border-radius: 12px;
        }

        .empty-state {
            animation: fadeIn 0.6s ease-out;
        }

        .page-wrapper {
            min-height: calc(100vh - 180px);
        }

        @media (max-width: 768px) {
            .card { border-radius: 12px; }
            .navbar-brand { font-size: 1.1rem; }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/peliculas?action=list">
            <i class="bi bi-film me-2"></i>CineManager
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link px-3" href="${pageContext.request.contextPath}/peliculas?action=list">
                        <i class="bi bi-camera-reels me-1"></i> Pel&iacute;culas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-3" href="${pageContext.request.contextPath}/generos?action=list">
                        <i class="bi bi-tags me-1"></i> G&eacute;neros
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-3" href="${pageContext.request.contextPath}/directores?action=list">
                        <i class="bi bi-people me-1"></i> Directores
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="page-wrapper">
