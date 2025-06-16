<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("username") == null) {
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
        .confirmation-container {
            padding: 2rem 0;
        }
        .confirmation-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container confirmation-container">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="confirmation-card">
                    <div class="card-body text-center p-5">
                        <div class="mb-4">
                            <i class="fas fa-undo text-info" style="font-size: 4rem;"></i>
                        </div>
                        
                        <h2 class="text-info mb-3">Car Returned Successfully!</h2>
                        
                        <% if(request.getAttribute("status") != null) { %>
                            <div class="alert alert-info">
                                <%= request.getAttribute("status") %>
                            </div>
                        <% } %>
                        
                        <% if(request.getAttribute("carId") != null) { %>
                            <p class="text-muted mb-4">
                                Car ID: <strong><%= request.getAttribute("carId") %></strong> has been returned and is now available for rental.
                            </p>
                        <% } %>
                        
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle me-2"></i>
                            Thank you for returning the car. The vehicle is now available for other customers.
                        </div>
                        
                        <div class="d-grid gap-2 d-md-block">
                            <a href="viewAllCars" class="btn btn-primary me-2">
                                <i class="fas fa-list me-1"></i>View All Cars
                            </a>
                            <a href="viewAvailableCars" class="btn btn-outline-success">
                                <i class="fas fa-car me-1"></i>Available Cars
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
