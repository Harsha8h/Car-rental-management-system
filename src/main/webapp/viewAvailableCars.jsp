<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Car" %>
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
    <title>Harsha Car Rental</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .available-cars-container {
            padding: 2rem 0;
        }
        .cars-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        .car-item {
            border: 2px solid #d4edda;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            background: white;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .car-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            border-color: #28a745;
        }
        .status-available {
            background: #28a745;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        .btn-action {
            border-radius: 20px;
            padding: 8px 20px;
            font-size: 0.875rem;
            font-weight: 600;
            margin: 0 2px;
        }
        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            margin-bottom: 2rem;
        }
        .page-header {
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
            padding: 1.5rem;
            border-radius: 15px 15px 0 0;
        }
        .price-highlight {
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 15px;
            font-weight: 600;
        }
        .car-feature {
            background: #f8f9fa;
            padding: 0.25rem 0.5rem;
            border-radius: 8px;
            font-size: 0.875rem;
            margin: 2px;
            display: inline-block;
        }
        .sort-section {
            background: #e9ecef;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <div class="container available-cars-container">
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container-fluid">
                <a class="navbar-brand" href="customer">
                    <i class="fas fa-car text-primary me-2"></i>
                    <strong>Car Rental System</strong>
                </a>
                <div class="navbar-nav ms-auto">
                    <span class="navbar-text me-3">
                        Welcome, <%= session.getAttribute("username") %>!
                    </span>
                    <a class="btn btn-outline-primary btn-sm me-2" href="customer">
                        <i class="fas fa-home me-1"></i>Dashboard
                    </a>
                    <a class="btn btn-outline-info btn-sm me-2" href="searchCar.jsp">
                        <i class="fas fa-search me-1"></i>Search Cars
                    </a>
                    <a class="btn btn-outline-danger btn-sm" href="logout">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </div>
            </div>
        </nav>

        <div class="row">
            <div class="col-12">
                <div class="cars-card">
                    <div class="page-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h3><i class="fas fa-check-circle me-2"></i>Available Cars for Rental</h3>
                                <p class="mb-0">Choose from our premium fleet of vehicles</p>
                            </div>
                            <div class="text-end">
                                <div class="h4 mb-0">
                                    <% 
                                    List<Car> availableCarList = (List<Car>) request.getAttribute("availableCarList");
                                    int availableCount = (availableCarList != null) ? availableCarList.size() : 0;
                                    %>
                                    <%= availableCount %> Available
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <% if(request.getAttribute("status") != null) { %>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>
                                <%= request.getAttribute("status") %>
                            </div>
                        <% } %>
                        
                        <% if(availableCarList != null && !availableCarList.isEmpty()) { %>
                            <div class="row">
                                <% for(Car car : availableCarList) { %>
                                <div class="col-lg-6 col-xl-4 mb-4">
                                    <div class="car-item">
                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <h5 class="mb-0 text-success"><%= car.getCarName() %></h5>
                                            <span class="status-available">
                                                <i class="fas fa-check-circle me-1"></i>Available
                                            </span>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <h6 class="text-primary"><%= car.getBrand() %> <%= car.getModel() %></h6>
                                        </div>
                                        
                                        <div class="car-details mb-3">
                                            <div class="row text-sm">
                                                <div class="col-6 mb-2">
                                                    <small class="text-muted"><i class="fas fa-hashtag me-1"></i>ID:</small> 
                                                    <strong><%= car.getCarId() %></strong>
                                                </div>
                                                <div class="col-6 mb-2">
                                                    <small class="text-muted"><i class="fas fa-calendar me-1"></i>Year:</small> 
                                                    <strong><%= car.getYear() %></strong>
                                                </div>
                                                <div class="col-6 mb-2">
                                                    <small class="text-muted"><i class="fas fa-palette me-1"></i>Color:</small> 
                                                    <strong><%= car.getColor() %></strong>
                                                </div>
                                                <div class="col-6 mb-2">
                                                    <small class="text-muted"><i class="fas fa-users me-1"></i>Seats:</small> 
                                                    <strong><%= car.getSeatingCapacity() %></strong>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <span class="car-feature">
                                                <i class="fas fa-gas-pump me-1"></i><%= car.getFuelType() %>
                                            </span>
                                            <span class="car-feature">
                                                <i class="fas fa-cogs me-1"></i><%= car.getTransmissionType() %>
                                            </span>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <div class="price-highlight">
                                                <i class="fas fa-rupee-sign me-1"></i><%= car.getRentalPrice() %>/day
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex flex-wrap justify-content-center">
                                            <a href="customer?action=searchCars&searchType=id&searchValue=<%= car.getCarId() %>" 
                                               class="btn btn-info btn-action btn-sm">
                                                <i class="fas fa-eye me-1"></i>View Details
                                            </a>
                                            
                                            <a href="rentCar?carId=<%= car.getCarId() %>" 
                                               class="btn btn-success btn-action btn-sm"
                                               onclick="return confirm('Are you sure you want to rent this car?')">
                                                <i class="fas fa-key me-1"></i>Rent Now
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                            
                            <div class="text-center mt-4">
                                <div class="alert alert-success d-inline-block">
                                    <i class="fas fa-check-circle me-2"></i>
                                    <strong><%= availableCarList.size() %></strong> cars ready for rental
                                </div>
                            </div>
                        <% } else { %>
                            <div class="text-center py-5">
                                <i class="fas fa-exclamation-triangle text-warning" style="font-size: 4rem; opacity: 0.7;"></i>
                                <h4 class="mt-3 text-muted">No Available Cars</h4>
                                <p class="text-muted">All cars are currently rented out. Please check back later.</p>
                                <div class="mt-4">
                                    <a href="customer" class="btn btn-primary me-2">
                                        <i class="fas fa-home me-2"></i>Back to Dashboard
                                    </a>
                                    <a href="searchCar.jsp" class="btn btn-info">
                                        <i class="fas fa-search me-2"></i>Search Cars
                                    </a>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>