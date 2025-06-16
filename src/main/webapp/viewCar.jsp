<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        .car-details-container {
            padding: 2rem 0;
        }
        .car-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .car-header {
            background: linear-gradient(45deg, #FF6B6B, #4ECDC4);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .detail-row {
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }
        .detail-row:last-child {
            border-bottom: none;
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
            border-radius: 25px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
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
    <div class="container car-details-container">
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container-fluid">
                <a class="navbar-brand" href="admin.jsp">
                    <i class="fas fa-car text-primary me-2"></i>
                    <strong>Car Rental System</strong>
                </a>
                <div class="navbar-nav ms-auto">
                    <a class="btn btn-outline-primary btn-sm me-2" href="searchCar.jsp">
                        <i class="fas fa-arrow-left me-1"></i>Back to Search
                    </a>
                    <a class="btn btn-outline-danger btn-sm" href="logout">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </div>
            </div>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <% Car car = (Car) request.getAttribute("car"); %>
                <% if(car != null) { %>
                <div class="car-card">
                    <div class="car-header">
                        <i class="fas fa-car" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                        <h2><%= car.getCarName() %></h2>
                        <p class="mb-0"><%= car.getBrand() %> <%= car.getModel() %></p>
                    </div>
                    
                    <div class="card-body p-4">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="detail-row">
                                    <div class="row">
                                        <div class="col-5"><strong><i class="fas fa-hashtag me-2"></i>Car ID:</strong></div>
                                        <div class="col-7"><%= car.getCarId() %></div>
                                    </div>
                                </div>
                                
                                <div class="detail-row">
                                    <div class="row">
                                        <div class="col-5"><strong><i class="fas fa-calendar me-2"></i>Year:</strong></div>
                                        <div class="col-7"><%= car.getYear() %></div>
                                    </div>
                                </div>
                                
                                <div class="detail-row">
                                    <div class="row">
                                        <div class="col-5"><strong><i class="fas fa-palette me-2"></i>Color:</strong></div>
                                        <div class="col-7"><%= car.getColor() %></div>
                                    </div>
                                </div>
                                
                                <div class="detail-row">
                                    <div class="row">
                                        <div class="col-5"><strong><i class="fas fa-gas-pump me-2"></i>Fuel Type:</strong></div>
                                        <div class="col-7"><%= car.getFuelType() %></div>
                                    </div>
                                </div>
                                
                                <div class="detail-row">
                                    <div class="row">
                                        <div class="col-5"><strong><i class="fas fa-users me-2"></i>Seating:</strong></div>
                                        <div class="col-7"><%= car.getSeatingCapacity() %> Seater</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="detail-row">
                                    <div class="row">
                                        <div class="col-5"><strong><i class="fas fa-cogs me-2"></i>Transmission:</strong></div>
                                        <div class="col-7"><%= car.getTransmissionType() %></div>
                                    </div>
                                </div>
                                
                                <div class="detail-row">
                                    <div class="row">
                                        <div class="col-5"><strong><i class="fas fa-dollar-sign me-2"></i>Price/Day:</strong></div>
                                        <div class="col-7">$<%= car.getRentalPrice() %></div>
                                    </div>
                                </div>
                                
                                <div class="detail-row">
                                    <div class="row">
                                        <div class="col-5"><strong><i class="fas fa-info-circle me-2"></i>Status:</strong></div>
                                        <div class="col-7">
                                            <span class="<%= "Available".equals(car.getAvailabilityStatus()) ? "status-available" : "status-rented" %>">
                                                <%= car.getAvailabilityStatus() %>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <hr class="my-4">
                        
                        <div class="text-center">
                            <% if("Available".equals(car.getAvailabilityStatus())) { %>
                                <a href="rentCar?carId=<%= car.getCarId() %>" class="btn btn-success btn-action me-2">
                                    <i class="fas fa-key me-2"></i>Rent Car
                                </a>
                            <% } else { %>
                                <a href="returnCar?carId=<%= car.getCarId() %>" class="btn btn-warning btn-action me-2">
                                    <i class="fas fa-undo me-2"></i>Return Car
                                </a>
                            <% } %>
                            
                            <a href="editCar.jsp?carId=<%= car.getCarId() %>" class="btn btn-primary btn-action me-2">
                                <i class="fas fa-edit me-2"></i>Edit Car
                            </a>
                            
                            <a href="deleteCar?carId=<%= car.getCarId() %>" class="btn btn-danger btn-action"
                               onclick="return confirm('Are you sure you want to delete this car?')">
                                <i class="fas fa-trash me-2"></i>Delete Car
                            </a>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="alert alert-warning text-center">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    No car details found.
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>