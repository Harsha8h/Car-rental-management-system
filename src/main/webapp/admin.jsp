<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("username") == null || 
       !"admin".equals(session.getAttribute("userType"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Harsha Car Rental Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .dashboard-container {
            padding: 2rem 0;
        }
        .dashboard-header {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.95);
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .card-add { border-left: 5px solid #28a745; }
        .card-view { border-left: 5px solid #007bff; }
        .card-search { border-left: 5px solid #ffc107; }
        .card-available { border-left: 5px solid #17a2b8; }
        .btn-card {
            background: linear-gradient(45deg, #FF6B6B, #4ECDC4);
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        .btn-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            color: white;
        }
        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            margin-bottom: 2rem;
        }
        .welcome-text {
            color: #333;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container dashboard-container">
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <i class="fas fa-car text-primary me-2"></i>
                    <strong>Car Rental Admin</strong>
                </a>
                <div class="navbar-nav ms-auto">
                    <span class="navbar-text me-3 welcome-text">
                        <i class="fas fa-user-shield me-2"></i>
                        Welcome, Administrator
                    </span>
                    <a class="btn btn-outline-danger btn-sm" href="logout">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </div>
            </div>
        </nav>

        <div class="dashboard-header text-center">
            <h1 class="display-4 text-primary mb-3">
                <i class="fas fa-tachometer-alt me-3"></i>Admin Dashboard
            </h1>
            <p class="lead text-muted">Manage your car rental fleet efficiently</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="card card-add text-center h-100">
                    <div class="card-body d-flex flex-column">
                        <i class="fas fa-plus-circle card-icon text-success"></i>
                        <h5 class="card-title">Add New Car</h5>
                        <p class="card-text flex-grow-1">Register a new vehicle to your fleet</p>
                        <a href="addCar.jsp" class="btn btn-card">
                            <i class="fas fa-plus me-2"></i>Add Car
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card card-view text-center h-100">
                    <div class="card-body d-flex flex-column">
                        <i class="fas fa-list card-icon text-primary"></i>
                        <h5 class="card-title">All Cars</h5>
                        <p class="card-text flex-grow-1">View and manage all vehicles in your fleet</p>
                        <a href="viewAllCars" class="btn btn-card">
                            <i class="fas fa-eye me-2"></i>View All
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card card-search text-center h-100">
                    <div class="card-body d-flex flex-column">
                        <i class="fas fa-search card-icon text-warning"></i>
                        <h5 class="card-title">Search Cars</h5>
                        <p class="card-text flex-grow-1">Find specific vehicles by ID or brand</p>
                        <a href="searchCar.jsp" class="btn btn-card">
                            <i class="fas fa-search me-2"></i>Search
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card card-available text-center h-100">
                    <div class="card-body d-flex flex-column">
                        <i class="fas fa-car-side card-icon text-info"></i>
                        <h5 class="card-title">Available Cars</h5>
                        <p class="card-text flex-grow-1">View cars ready for rental</p>
                        <a href="viewAvailableCars" class="btn btn-card">
                            <i class="fas fa-check-circle me-2"></i>View Available
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-chart-bar me-2"></i>Quick Statistics
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col-md-3">
                                <div class="stat-item">
                                    <h3 class="text-primary">
                                        <i class="fas fa-car me-2"></i>10
                                    </h3>
                                    <p class="text-muted">Total Cars</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stat-item">
                                    <h3 class="text-success">
                                        <i class="fas fa-check-circle me-2"></i>9
                                    </h3>
                                    <p class="text-muted">Available</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stat-item">
                                    <h3 class="text-warning">
                                        <i class="fas fa-clock me-2"></i>1
                                    </h3>
                                    <p class="text-muted">Rented</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stat-item">
                                    <h3 class="text-info">
                                        <i class="fas fa-dollar-sign me-2"></i>$55
                                    </h3>
                                    <p class="text-muted">Avg. Price</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>