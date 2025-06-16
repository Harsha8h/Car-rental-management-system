<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Car" %>
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
        .cars-container {
            padding: 2rem 0;
        }
        .cars-card {
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
            margin: 0 2px;
        }
        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            margin-bottom: 2rem;
        }
        .page-header {
            background: linear-gradient(45deg, #FF6B6B, #4ECDC4);
            color: white;
            padding: 1.5rem;
            border-radius: 15px 15px 0 0;
        }
        .filter-section {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <div class="container cars-container">
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container-fluid">
                <a class="navbar-brand" href="admin.jsp">
                    <i class="fas fa-car text-primary me-2"></i>
                    <strong>Harsha Car Rental System</strong>
                </a>
                <div class="navbar-nav ms-auto">
                    <a class="btn btn-outline-success btn-sm me-2" href="addCar.jsp">
                        <i class="fas fa-plus me-1"></i>Add New Car
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
                <div class="cars-card">
                    <div class="page-header">
                        <h3><i class="fas fa-list me-2"></i>All Cars in Fleet</h3>
                        <p class="mb-0">Manage your entire car rental fleet</p>
                    </div>
                    
                    <div class="card-body">
                        <div class="filter-section">
                            <form method="get" action="viewAllCars" class="row g-3">
                                <div class="col-md-3">
                                    <select name="statusFilter" class="form-select">
                                        <option value="">All Status</option>
                                        <option value="Available" <%= "Available".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>Available</option>
                                        <option value="Rented" <%= "Rented".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>Rented</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select name="brandFilter" class="form-select">
                                        <option value="">All Brands</option>
                                        <option value="Toyota" <%= "Toyota".equals(request.getParameter("brandFilter")) ? "selected" : "" %>>Toyota</option>
                                        <option value="Honda" <%= "Honda".equals(request.getParameter("brandFilter")) ? "selected" : "" %>>Honda</option>
                                        <option value="Hyundai" <%= "Hyundai".equals(request.getParameter("brandFilter")) ? "selected" : "" %>>Hyundai</option>
                                        <option value="Maruti Suzuki" <%= "Maruti Suzuki".equals(request.getParameter("brandFilter")) ? "selected" : "" %>>Maruti Suzuki</option>
                                        <option value="Tata" <%= "Tata".equals(request.getParameter("brandFilter")) ? "selected" : "" %>>Tata</option>
                                        <option value="BMW" <%= "BMW".equals(request.getParameter("brandFilter")) ? "selected" : "" %>>BMW</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select name="fuelFilter" class="form-select">
                                        <option value="">All Fuel Types</option>
                                        <option value="Petrol" <%= "Petrol".equals(request.getParameter("fuelFilter")) ? "selected" : "" %>>Petrol</option>
                                        <option value="Diesel" <%= "Diesel".equals(request.getParameter("fuelFilter")) ? "selected" : "" %>>Diesel</option>
                                        <option value="Electric" <%= "Electric".equals(request.getParameter("fuelFilter")) ? "selected" : "" %>>Electric</option>
                                        <option value="CNG" <%= "CNG".equals(request.getParameter("fuelFilter")) ? "selected" : "" %>>CNG</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-filter me-1"></i>Filter
                                    </button>
                                    <a href="viewAllCars" class="btn btn-outline-secondary ms-2">
                                        <i class="fas fa-undo me-1"></i>Reset
                                    </a>
                                </div>
                            </form>
                        </div>

                        <% if(request.getAttribute("status") != null) { %>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>
                                <%= request.getAttribute("status") %>
                            </div>
                        <% } %>
                        
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
                                                    <small class="text-muted"><i class="fas fa-tag me-1"></i>Brand:</small> <%= car.getBrand() %>
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
                                                <div class="col-12 mt-2">
                                                    <small class="text-muted"><i class="fas fa-cogs me-1"></i>Transmission:</small> <%= car.getTransmissionType() %>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <div>
                                                <h6 class="text-success mb-0">$<%= car.getRentalPrice() %>/day</h6>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex flex-wrap justify-content-center">
                                            <a href="searchCar?searchType=id&searchValue=<%= car.getCarId() %>" 
                                               class="btn btn-primary btn-action btn-sm">
                                                <i class="fas fa-eye me-1"></i>View
                                            </a>
                                            
                                            <a href="editCar.jsp?carId=<%= car.getCarId() %>" 
                                               class="btn btn-warning btn-action btn-sm">
                                                <i class="fas fa-edit me-1"></i>Edit
                                            </a>
                                            
                                            <% if("Available".equals(car.getAvailabilityStatus())) { %>
                                                <a href="rentCar?carId=<%= car.getCarId() %>" 
                                                   class="btn btn-success btn-action btn-sm">
                                                    <i class="fas fa-key me-1"></i>Rent
                                                </a>
                                            <% } else { %>
                                                <a href="returnCar?carId=<%= car.getCarId() %>" 
                                                   class="btn btn-info btn-action btn-sm">
                                                    <i class="fas fa-undo me-1"></i>Return
                                                </a>
                                            <% } %>
                                            
                                            <a href="deleteCar?carId=<%= car.getCarId() %>" 
                                               class="btn btn-danger btn-action btn-sm"
                                               onclick="return confirm('Are you sure you want to delete this car?')">
                                                <i class="fas fa-trash me-1"></i>Delete
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                            
                            <div class="text-center mt-4">
                                <p class="text-muted">Showing <%= carList.size() %> car(s) in your fleet</p>
                            </div>
                        <% } else { %>
                            <div class="text-center py-5">
                                <i class="fas fa-car text-muted" style="font-size: 4rem; opacity: 0.3;"></i>
                                <h4 class="mt-3 text-muted">No Cars Found</h4>
                                <p class="text-muted">Start by adding some cars to your fleet</p>
                                <a href="addCar.jsp" class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i>Add First Car
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