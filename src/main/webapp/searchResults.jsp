<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Car" %>
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
        .results-container {
            padding: 2rem 0;
        }
        .results-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        .car-item {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            background: white;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .car-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        .status-available {
            background: #d4edda;
            color: #155724;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        .status-rented {
            background: #f8d7da;
            color: #721c24;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        .btn-action {
            border-radius: 20px;
            padding: 8px 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            margin-bottom: 2rem;
        }
        .search-info {
            background: linear-gradient(45deg, #FF6B6B, #4ECDC4);
            color: white;
            padding: 1.5rem;
            border-radius: 15px 15px 0 0;
        }
    </style>
</head>
<body>
    <div class="container results-container">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container-fluid">
                <a class="navbar-brand" href="admin.jsp">
                    <i class="fas fa-car text-primary me-2"></i>
                    <strong>Harsha Car Rental System</strong>
                </a>
                <div class="navbar-nav ms-auto">
                    <a class="btn btn-outline-primary btn-sm me-2" href="searchCar.jsp">
                        <i class="fas fa-search me-1"></i>New Search
                    </a>
                    <a class="btn btn-outline-secondary btn-sm me-2" href="admin.jsp">
                        <i class="fas fa-home me-1"></i>Dashboard
                    </a>
                    <a class="btn btn-outline-danger btn-sm" href="logout">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </div>
            </div>
        </nav>

        <div class="row">
            <div class="col-12">
                <div class="results-card">
                    <div class="search-info">
                        <h3><i class="fas fa-search me-2"></i>Search Results</h3>
                        <% String searchBrand = (String) request.getAttribute("searchBrand"); %>
                        <% if(searchBrand != null) { %>
                            <p class="mb-0">Showing available cars for brand: <strong><%= searchBrand %></strong></p>
                        <% } %>
                    </div>
                    
                    <div class="card-body p-4">
                        <% 
                        List<Car> carList = (List<Car>) request.getAttribute("carList");
                        if(carList != null && !carList.isEmpty()) { 
                        %>
                            <div class="row">
                                <% for(Car car : carList) { %>
                                <div class="col-lg-6 col-xl-4 mb-4">
                                    <div class="car-item">
                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <h5 class="mb-0 text-primary"><%= car.getCarName() %></h5>
                                            <span class="<%= "Available".equals(car.getAvailabilityStatus()) ? "status-available" : "status-rented" %>">
                                                <%= car.getAvailabilityStatus() %>
                                            </span>
                                        </div>
                                        
                                        <div class="car-details mb-3">
                                            <div class="row text-sm">
                                                <div class="col-6">
                                                    <small class="text-muted"><i class="fas fa-hashtag me-1"></i>ID:</small> <%= car.getCarId() %>
                                                </div>
                                                <div class="col-6">
                                                    <small class="text-muted"><i class="fas fa-calendar me-1"></i>Year:</small> <%= car.getYear() %>
                                                </div>
                                                <div class="col-6">
                                                    <small class="text-muted"><i class="fas fa-palette me-1"></i>Color:</small> <%= car.getColor() %>
                                                </div>
                                                <div class="col-6">
                                                    <small class="text-muted"><i class="fas fa-users me-1"></i>Seats:</small> <%= car.getSeatingCapacity() %>
                                                </div>
                                                <div class="col-6">
                                                    <small class="text-muted"><i class="fas fa-gas-pump me-1"></i>Fuel:</small> <%= car.getFuelType() %>
                                                </div>
                                                <div class="col-6">
                                                    <small class="text-muted"><i class="fas fa-cogs me-1"></i>Trans:</small> <%= car.getTransmissionType() %>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="text-success mb-0">$<%= car.getRentalPrice() %>/day</h6>
                                            </div>
                                            <div>
                                                <a href="searchCar?searchType=id&searchValue=<%= car.getCarId() %>" 
                                                   class="btn btn-primary btn-action btn-sm">
                                                    <i class="fas fa-eye me-1"></i>View
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                            
                            <div class="text-center mt-4">
                                <p class="text-muted">Found <%= carList.size() %> car(s)</p>
                            </div>
                        <% } else { %>
                            <div class="text-center py-5">
                                <i class="fas fa-search text-muted" style="font-size: 4rem; opacity: 0.3;"></i>
                                <h4 class="mt-3 text-muted">No Cars Found</h4>
                                <p class="text-muted">Try searching with different criteria</p>
                                <a href="searchCar.jsp" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Search Again
                                </a>
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