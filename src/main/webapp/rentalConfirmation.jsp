<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CarDao" %>
<%@ page import="model.Car" %>
<%@ page import="java.util.Date" %>
<%
    if(session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Car car = null;
    Integer carId = (Integer) request.getAttribute("carId");
    if(carId != null) {
        try {
            CarDao dao = new CarDao();
            car = dao.searchCar(carId);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    long timestamp = new java.util.Date().getTime();
    String rentalId = "CR" + timestamp;
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
            padding: 3rem 0;
        }
        .confirmation-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            overflow: hidden;
        }
        .success-header {
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
        }
        .success-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            animation: bounce 2s infinite;
        }
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-30px);
            }
            60% {
                transform: translateY(-15px);
            }
        }
        .rental-details {
            padding: 2rem;
        }
        .detail-item {
            background: #f8f9fa;
            border-left: 4px solid #28a745;
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 5px;
        }
        .detail-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
        }
        .detail-value {
            font-size: 1.1rem;
            color: #28a745;
        }
        .btn-custom {
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        .rental-id {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 2rem;
        }
        .instructions {
            background: #e3f2fd;
            border: 1px solid #2196f3;
            border-radius: 10px;
            padding: 1.5rem;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <div class="container confirmation-container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="confirmation-card">
                    <div class="success-header">
                        <i class="fas fa-check-circle success-icon"></i>
                        <h2>Rental Confirmed Successfully!</h2>
                        <p class="mb-0">Your car has been rented. Here are the details:</p>
                    </div>
                    
                    <div class="rental-details">
                        <% if(request.getAttribute("status") != null) { %>
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle me-2"></i>
                                <%= request.getAttribute("status") %>
                            </div>
                        <% } %>
                        
                        <div class="rental-id">
                            <h5><i class="fas fa-hashtag me-2"></i>Rental ID: <span id="rentalId"><%= rentalId %></span></h5>
                            <small>Please save this ID for future reference</small>
                        </div>
                        
                        <% if(car != null && car.getCarId() != 0) { %>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-car me-2"></i>Car Name
                                        </div>
                                        <div class="detail-value"><%= car.getCarName() %></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-hashtag me-2"></i>Car ID
                                        </div>
                                        <div class="detail-value"><%= car.getCarId() %></div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-tag me-2"></i>Brand & Model
                                        </div>
                                        <div class="detail-value"><%= car.getBrand() %> <%= car.getModel() %></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-calendar me-2"></i>Year
                                        </div>
                                        <div class="detail-value"><%= car.getYear() %></div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-palette me-2"></i>Color
                                        </div>
                                        <div class="detail-value"><%= car.getColor() %></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-users me-2"></i>Seating Capacity
                                        </div>
                                        <div class="detail-value"><%= car.getSeatingCapacity() %> Seater</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-gas-pump me-2"></i>Fuel Type
                                        </div>
                                        <div class="detail-value"><%= car.getFuelType() %></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-cogs me-2"></i>Transmission
                                        </div>
                                        <div class="detail-value"><%= car.getTransmissionType() %></div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-money-bill me-2"></i>Daily Rental Rate
                                        </div>
                                        <div class="detail-value">$<%= car.getRentalPrice() %>/day</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="detail-item">
                                        <div class="detail-label">
                                            <i class="fas fa-clock me-2"></i>Rental Date
                                        </div>
                                        <div class="detail-value"><%= new java.util.Date() %></div>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                        
                        <div class="instructions">
                            <h6><i class="fas fa-info-circle me-2"></i>Important Instructions:</h6>
                            <ul class="mb-0">
                                <li>Please keep this confirmation for your records</li>
                                <li>Bring a valid driver's license and identification</li>
                                <li>The car should be returned in the same condition</li>
                                <li>Contact us immediately for any issues during rental</li>
                                <li>Late returns may incur additional charges</li>
                            </ul>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <% String userType = (String) session.getAttribute("userType"); %>
                            <% if("admin".equals(userType)) { %>
                                <a href="viewAllCars" class="btn btn-outline-primary btn-custom">
                                    <i class="fas fa-list me-2"></i>View All Cars
                                </a>
                                <a href="admin.jsp" class="btn btn-primary btn-custom">
                                    <i class="fas fa-home me-2"></i>Admin Dashboard
                                </a>
                            <% } else { %>
                                <a href="viewAvailableCars" class="btn btn-outline-primary btn-custom">
                                    <i class="fas fa-search me-2"></i>Browse Cars
                                </a>
                                <a href="customer.jsp" class="btn btn-primary btn-custom">
                                    <i class="fas fa-home me-2"></i>Dashboard
                                </a>
                            <% } %>
                        </div>
                        
                        <div class="text-center mt-3">
                            <button onclick="window.print()" class="btn btn-success btn-custom">
                                <i class="fas fa-print me-2"></i>Print Confirmation
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>
