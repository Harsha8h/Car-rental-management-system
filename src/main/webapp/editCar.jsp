<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Car" %>
<%@ page import="dao.CarDao" %>
<%
    if(session.getAttribute("username") == null || 
       !"admin".equals(session.getAttribute("userType"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Car car = null;
    String carId = request.getParameter("carId");
    if(carId != null && !carId.isEmpty()) {
        try {
            CarDao dao = new CarDao();
            car = dao.searchCar(Integer.parseInt(carId));
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    if(car == null) {
        car = (Car) request.getAttribute("car");
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
        .edit-container {
            padding: 2rem 0;
        }
        .edit-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }
        .page-header {
            background: linear-gradient(45deg, #FF6B6B, #4ECDC4);
            color: white;
            padding: 2rem;
            border-radius: 15px 15px 0 0;
        }
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
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
        .form-section {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        .section-title {
            color: #495057;
            font-weight: 600;
            margin-bottom: 1rem;
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="container edit-container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="edit-card">
                    <div class="page-header text-center">
                        <h2><i class="fas fa-edit me-3"></i>Edit Car Details</h2>
                        <p class="mb-0">Update car information in your fleet</p>
                    </div>
                    
                    <div class="card-body p-4">
                        <% if(request.getAttribute("status") != null) { %>
                            <div class="alert alert-info alert-dismissible fade show">
                                <i class="fas fa-info-circle me-2"></i>
                                <%= request.getAttribute("status") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>
                        
                        <% if(car != null && car.getCarId() != 0) { %>
                            <form action="updateCar" method="post">
                                <input type="hidden" name="carId" value="<%= car.getCarId() %>">
                                
                                <div class="form-section">
                                    <h5 class="section-title">
                                        <i class="fas fa-info-circle me-2"></i>Basic Information
                                    </h5>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="carName" class="form-label">
                                                <i class="fas fa-car me-1"></i>Car Name *
                                            </label>
                                            <input type="text" class="form-control" id="carName" name="carName" 
                                                   value="<%= car.getCarName() %>" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="brand" class="form-label">
                                                <i class="fas fa-tag me-1"></i>Brand *
                                            </label>
                                            <select class="form-select" id="brand" name="brand" required>
                                                <option value="">Select Brand</option>
                                                <option value="Toyota" <%= "Toyota".equals(car.getBrand()) ? "selected" : "" %>>Toyota</option>
                                                <option value="Honda" <%= "Honda".equals(car.getBrand()) ? "selected" : "" %>>Honda</option>
                                                <option value="Hyundai" <%= "Hyundai".equals(car.getBrand()) ? "selected" : "" %>>Hyundai</option>
                                                <option value="Maruti Suzuki" <%= "Maruti Suzuki".equals(car.getBrand()) ? "selected" : "" %>>Maruti Suzuki</option>
                                                <option value="Tata" <%= "Tata".equals(car.getBrand()) ? "selected" : "" %>>Tata</option>
                                                <option value="BMW" <%= "BMW".equals(car.getBrand()) ? "selected" : "" %>>BMW</option>
                                                <option value="Audi" <%= "Audi".equals(car.getBrand()) ? "selected" : "" %>>Audi</option>
                                                <option value="Mercedes-Benz" <%= "Mercedes-Benz".equals(car.getBrand()) ? "selected" : "" %>>Mercedes-Benz</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="model" class="form-label">
                                                <i class="fas fa-cog me-1"></i>Model *
                                            </label>
                                            <input type="text" class="form-control" id="model" name="model" 
                                                   value="<%= car.getModel() %>" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="year" class="form-label">
                                                <i class="fas fa-calendar me-1"></i>Year *
                                            </label>
                                            <input type="number" class="form-control" id="year" name="year" 
                                                   value="<%= car.getYear() %>" min="1990" max="2024" required>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-section">
                                    <h5 class="section-title">
                                        <i class="fas fa-cogs me-2"></i>Specifications
                                    </h5>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="color" class="form-label">
                                                <i class="fas fa-palette me-1"></i>Color *
                                            </label>
                                            <input type="text" class="form-control" id="color" name="color" 
                                                   value="<%= car.getColor() %>" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="seatingCapacity" class="form-label">
                                                <i class="fas fa-users me-1"></i>Seating Capacity *
                                            </label>
                                            <select class="form-select" id="seatingCapacity" name="seatingCapacity" required>
                                                <option value="">Select Capacity</option>
                                                <option value="2" <%= car.getSeatingCapacity() == 2 ? "selected" : "" %>>2 Seater</option>
                                                <option value="4" <%= car.getSeatingCapacity() == 4 ? "selected" : "" %>>4 Seater</option>
                                                <option value="5" <%= car.getSeatingCapacity() == 5 ? "selected" : "" %>>5 Seater</option>
                                                <option value="7" <%= car.getSeatingCapacity() == 7 ? "selected" : "" %>>7 Seater</option>
                                                <option value="8" <%= car.getSeatingCapacity() == 8 ? "selected" : "" %>>8 Seater</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="fuelType" class="form-label">
                                                <i class="fas fa-gas-pump me-1"></i>Fuel Type *
                                            </label>
                                            <select class="form-select" id="fuelType" name="fuelType" required>
                                                <option value="">Select Fuel Type</option>
                                                <option value="Petrol" <%= "Petrol".equals(car.getFuelType()) ? "selected" : "" %>>Petrol</option>
                                                <option value="Diesel" <%= "Diesel".equals(car.getFuelType()) ? "selected" : "" %>>Diesel</option>
                                                <option value="Electric" <%= "Electric".equals(car.getFuelType()) ? "selected" : "" %>>Electric</option>
                                                <option value="CNG" <%= "CNG".equals(car.getFuelType()) ? "selected" : "" %>>CNG</option>
                                                <option value="Hybrid" <%= "Hybrid".equals(car.getFuelType()) ? "selected" : "" %>>Hybrid</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="transmissionType" class="form-label">
                                                <i class="fas fa-cogs me-1"></i>Transmission *
                                            </label>
                                            <select class="form-select" id="transmissionType" name="transmissionType" required>
                                                <option value="">Select Transmission</option>
                                                <option value="Manual" <%= "Manual".equals(car.getTransmissionType()) ? "selected" : "" %>>Manual</option>
                                                <option value="Automatic" <%= "Automatic".equals(car.getTransmissionType()) ? "selected" : "" %>>Automatic</option>
                                                <option value="CVT" <%= "CVT".equals(car.getTransmissionType()) ? "selected" : "" %>>CVT</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-section">
                                    <h5 class="section-title">
                                        <i class="fas fa-dollar-sign me-2"></i>Pricing & Availability
                                    </h5>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="rentalPrice" class="form-label">
                                                <i class="fas fa-money-bill me-1"></i>Rental Price (per day) *
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text">$</span>
                                                <input type="number" class="form-control" id="rentalPrice" name="rentalPrice" 
                                                       value="<%= car.getRentalPrice() %>" min="0" step="0.01" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="availabilityStatus" class="form-label">
                                                <i class="fas fa-check-circle me-1"></i>Availability Status *
                                            </label>
                                            <select class="form-select" id="availabilityStatus" name="availabilityStatus" required>
                                                <option value="Available" <%= "Available".equals(car.getAvailabilityStatus()) ? "selected" : "" %>>Available</option>
                                                <option value="Rented" <%= "Rented".equals(car.getAvailabilityStatus()) ? "selected" : "" %>>Rented</option>
                                                <option value="Maintenance" <%= "Maintenance".equals(car.getAvailabilityStatus()) ? "selected" : "" %>>Under Maintenance</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="d-flex justify-content-between">
                                    <a href="viewAllCars" class="btn btn-secondary btn-custom">
                                        <i class="fas fa-arrow-left me-2"></i>Back to Fleet
                                    </a>
                                    <div>
                                        <button type="reset" class="btn btn-outline-warning btn-custom me-2">
                                            <i class="fas fa-undo me-2"></i>Reset
                                        </button>
                                        <button type="submit" class="btn btn-success btn-custom">
                                            <i class="fas fa-save me-2"></i>Update Car
                                        </button>
                                    </div>
                                </div>
                            </form>
                        <% } else { %>
                            <div class="text-center py-5">
                                <i class="fas fa-exclamation-triangle text-warning" style="font-size: 4rem;"></i>
                                <h4 class="mt-3">Car Not Found</h4>
                                <p class="text-muted">The requested car could not be found in the system.</p>
                                <a href="viewAllCars" class="btn btn-primary btn-custom">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Fleet
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