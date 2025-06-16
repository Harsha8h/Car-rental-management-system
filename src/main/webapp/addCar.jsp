<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Harsha Car Rental Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background: #f5f5f5;
            line-height: 1.6;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }
        
        .back-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s;
        }
        
        .back-btn:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .main-content {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        
        .form-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .form-header h2 {
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .form-header p {
            color: #666;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: 500;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e1e1e1;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn-container {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }
        
        .btn {
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .status-message {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            text-align: center;
        }
        
        .status-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <h1>🚗 Add New Car</h1>
            <a href="admin.jsp" class="back-btn">← Back to Dashboard</a>
        </div>
    </header>
    
    <main class="main-content">
        <div class="form-container">
            <div class="form-header">
                <h2>Add New Car</h2>
                <p>Fill in the details to add a new car to your fleet</p>
            </div>
            
            <% if(request.getAttribute("status") != null) { %>
                <div class="status-message <%= request.getAttribute("status").toString().contains("success") ? "status-success" : "status-error" %>">
                    <%= request.getAttribute("status") %>
                </div>
            <% } %>
            
            <form action="saveCar" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="carId">Car ID:</label>
                        <input type="number" id="carId" name="carId" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="carName">Car Name:</label>
                        <input type="text" id="carName" name="carName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="brand">Brand:</label>
                        <select id="brand" name="brand" required>
                            <option value="">Select Brand</option>
                            <option value="Toyota">Toyota</option>
                            <option value="Honda">Honda</option>
                            <option value="Hyundai">Hyundai</option>
                            <option value="Maruti Suzuki">Maruti Suzuki</option>
                            <option value="Tata">Tata</option>
                            <option value="Mahindra">Mahindra</option>
                            <option value="Ford">Ford</option>
                            <option value="Volkswagen">Volkswagen</option>
                            <option value="BMW">BMW</option>
                            <option value="Mercedes-Benz">Mercedes-Benz</option>
                            <option value="Audi">Audi</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="model">Model:</label>
                        <input type="text" id="model" name="model" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="year">Year:</label>
                        <input type="number" id="year" name="year" min="2000" max="2024" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="color">Color:</label>
                        <input type="text" id="color" name="color" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="rentalPrice">Rental Price (per day):</label>
                        <input type="number" id="rentalPrice" name="rentalPrice" step="0.01" min="0" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="fuelType">Fuel Type:</label>
                        <select id="fuelType" name="fuelType" required>
                            <option value="">Select Fuel Type</option>
                            <option value="Petrol">Petrol</option>
                            <option value="Diesel">Diesel</option>
                            <option value="CNG">CNG</option>
                            <option value="Electric">Electric</option>
                            <option value="Hybrid">Hybrid</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="seatingCapacity">Seating Capacity:</label>
                        <select id="seatingCapacity" name="seatingCapacity" required>
                            <option value="">Select Capacity</option>
                            <option value="2">2 Seater</option>
                            <option value="4">4 Seater</option>
                            <option value="5">5 Seater</option>
                            <option value="7">7 Seater</option>
                            <option value="8">8 Seater</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="transmissionType">Transmission:</label>
                        <select id="transmissionType" name="transmissionType" required>
                            <option value="">Select Transmission</option>
                            <option value="Manual">Manual</option>
                            <option value="Automatic">Automatic</option>
                            <option value="CVT">CVT</option>
                        </select>
                    </div>
                </div>
                
                <div class="btn-container">
                    <button type="submit" class="btn btn-primary">Add Car</button>
                    <button type="reset" class="btn btn-secondary">Reset Form</button>
                </div>
            </form>
        </div>
    </main>
</body>
</html>