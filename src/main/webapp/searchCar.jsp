<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        .search-container {
            padding: 2rem 0;
        }
        .search-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }
        .btn-search {
            background: linear-gradient(45deg, #FF6B6B, #4ECDC4);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        .btn-search:hover {
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
    </style>
</head>
<body>
    <div class="container search-container">
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container-fluid">
                <a class="navbar-brand" href="admin.jsp">
                    <i class="fas fa-car text-primary me-2"></i>
                    <strong>Car Rental System</strong>
                </a>
                <div class="navbar-nav ms-auto">
                    <a class="btn btn-outline-primary btn-sm me-2" href="admin.jsp">
                        <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                    </a>
                    <a class="btn btn-outline-danger btn-sm" href="logout">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </div>
            </div>
        </nav>

        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="search-card">
                    <div class="text-center mb-4">
                        <i class="fas fa-search text-primary" style="font-size: 3rem;"></i>
                        <h2 class="mt-3 mb-2">Search Cars</h2>
                        <p class="text-muted">Find cars by ID or brand name</p>
                    </div>

                    <% if(request.getAttribute("status") != null) { %>
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <%= request.getAttribute("status") %>
                        </div>
                    <% } %>

                    <form action="searchCar" method="get">
                        <div class="mb-3">
                            <label for="searchType" class="form-label">Search Type:</label>
                            <select class="form-select" id="searchType" name="searchType" required>
                                <option value="">Select search type</option>
                                <option value="id">Search by Car ID</option>
                                <option value="brand">Search by Brand</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label for="searchValue" class="form-label">Search Value:</label>
                            <input type="text" class="form-control" id="searchValue" name="searchValue" 
                                   placeholder="Enter car ID or brand name" required>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-search">
                                <i class="fas fa-search me-2"></i>Search Cars
                            </button>
                            <button type="reset" class="btn btn-outline-secondary">
                                <i class="fas fa-undo me-2"></i>Reset Form
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>