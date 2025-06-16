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
        .error-container {
            padding: 2rem 0;
        }
        .error-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container error-container">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="error-card">
                    <div class="card-body text-center p-5">
                        <div class="mb-4">
                            <i class="fas fa-exclamation-triangle text-warning" style="font-size: 4rem;"></i>
                        </div>
                        
                        <h2 class="text-danger mb-3">Oops! Something went wrong</h2>
                        
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } else { %>
                            <p class="text-muted mb-4">
                                An unexpected error occurred. Please try again later.
                            </p>
                        <% } %>
                        
                        <div class="d-grid gap-2 d-md-block">
                            <a href="javascript:history.back()" class="btn btn-secondary me-2">
                                <i class="fas fa-arrow-left me-1"></i>Go Back
                            </a>
                            <% if(session.getAttribute("userType") != null && "admin".equals(session.getAttribute("userType"))) { %>
                                <a href="admin.jsp" class="btn btn-primary">
                                    <i class="fas fa-home me-1"></i>Dashboard
                                </a>
                            <% } else { %>
                                <a href="login.jsp" class="btn btn-primary">
                                    <i class="fas fa-home me-1"></i>Home
                                </a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
