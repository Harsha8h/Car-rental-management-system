<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Car" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Harsha Car Rental System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        .header {
            background: rgba(255, 255, 255, 0.95);
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: #667eea;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .welcome-text {
            color: #555;
            font-weight: 500;
        }
        
        .logout-btn {
            background: #ff6b6b;
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s;
        }
        
        .logout-btn:hover {
            background: #ff5252;
        }
        
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        
        .dashboard-title {
            text-align: center;
            color: white;
            font-size: 2.5rem;
            margin-bottom: 2rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: #666;
            font-size: 1.1rem;
        }
        
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }
        
        .action-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
        }
        
        .action-title {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 1rem;
            font-weight: 600;
        }
        
        .action-description {
            color: #666;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .action-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
            font-weight: 500;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .cars-section {
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        
        .section-title {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        
        .cars-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        
        .car-card {
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 1.5rem;
            transition: all 0.3s;
        }
        
        .car-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .car-name {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .car-details {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }
        
        .car-price {
            font-size: 1.1rem;
            font-weight: 600;
            color: #667eea;
            margin-bottom: 1rem;
        }
        
        .rent-btn {
            background: #28a745;
            color: white;
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
            transition: background 0.3s;
        }
        
        .rent-btn:hover {
            background: #218838;
        }
        
        .no-cars {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 2rem;
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 1rem;
            }
            
            .dashboard-title {
                font-size: 2rem;
            }
            
            .container {
                padding: 0 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">🚗 Harsha Car Rentals</div>
        <div class="user-info">
            <span class="welcome-text">Welcome, <%= session.getAttribute("username") %></span>
            <a href="logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="container">
        <h1 class="dashboard-title">Customer Dashboard</h1>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("totalAvailableCars") != null ? request.getAttribute("totalAvailableCars") : 0 %></div>
                <div class="stat-label">Available Cars</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">0</div>
                <div class="stat-label">My Rentals</div>
            </div>
        </div>

        <div class="actions-grid">
            <div class="action-card">
                <div class="action-title">🔍 Search Cars</div>
                <div class="action-description">Find the perfect car for your needs by searching by brand or ID.</div>
                <a href="searchCar.jsp" class="action-btn">Search Now</a>
            </div>
            
            <div class="action-card">
                <div class="action-title">🚗 View Available Cars</div>
                <div class="action-description">Browse all available cars in our fleet with detailed information.</div>
                <a href="customer?action=viewAvailable" class="action-btn">View Cars</a>
            </div>
            
        </div>

        <div class="cars-section">
            <h2 class="section-title">Featured Available Cars</h2>
            
            <% 
                List<Car> availableCarList = (List<Car>) request.getAttribute("availableCarList");
                if (availableCarList != null && !availableCarList.isEmpty()) {
                    int displayCount = Math.min(availableCarList.size(), 6); 
            %>
            <div class="cars-grid">
                <% for (int i = 0; i < displayCount; i++) { 
                    Car car = availableCarList.get(i);
                %>
                <div class="car-card">
                    <div class="car-name"><%= car.getCarName() %></div>
                    <div class="car-details">
                        <strong>Brand:</strong> <%= car.getBrand() %><br>
                        <strong>Model:</strong> <%= car.getModel() %><br>
                        <strong>Year:</strong> <%= car.getYear() %><br>
                        <strong>Fuel:</strong> <%= car.getFuelType() %><br>
                        <strong>Seats:</strong> <%= car.getSeatingCapacity() %><br>
                        <strong>Transmission:</strong> <%= car.getTransmissionType() %>
                    </div>
                    <div class="car-price">₹<%= car.getRentalPrice() %>/day</div>
                    <a href="rentCar?carId=<%= car.getCarId() %>" class="rent-btn" 
                       onclick="return confirm('Are you sure you want to rent this car?')">
                        Rent Now
                    </a>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="no-cars">
                <p>No cars available at the moment. Please check back later.</p>
            </div>
            <% } %>
            
            <% if (availableCarList != null && availableCarList.size() > 6) { %>
            <div style="text-align: center; margin-top: 2rem;">
                <a href="customer?action=viewAvailable" class="action-btn">View All Available Cars</a>
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>