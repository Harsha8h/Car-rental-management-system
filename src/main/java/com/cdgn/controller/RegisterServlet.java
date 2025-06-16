package com.cdgn.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/carrentaldb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";
    
    public RegisterServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String licenseNumber = request.getParameter("licenseNumber");
        
        if (firstName == null || lastName == null || email == null || phone == null || 
            password == null || confirmPassword == null || address == null || 
            dateOfBirth == null || licenseNumber == null ||
            firstName.trim().isEmpty() || lastName.trim().isEmpty() || 
            email.trim().isEmpty() || phone.trim().isEmpty() || 
            password.trim().isEmpty() || address.trim().isEmpty() || 
            licenseNumber.trim().isEmpty()) {
            
            response.sendRedirect("register.jsp?error=All fields are required!");
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Passwords do not match!");
            return;
        }
        
        if (password.length() < 6) {
            response.sendRedirect("register.jsp?error=Password must be at least 6 characters long!");
            return;
        }
        
        if (!isValidEmail(email)) {
            response.sendRedirect("register.jsp?error=Please enter a valid email address!");
            return;
        }
        
        if (!isValidPhone(phone)) {
            response.sendRedirect("register.jsp?error=Please enter a valid phone number!");
            return;
        }
        
        if (!isValidAge(dateOfBirth)) {
            response.sendRedirect("register.jsp?error=You must be at least 18 years old to register!");
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String checkEmailQuery = "SELECT email FROM customers WHERE email = ?";
            pstmt = conn.prepareStatement(checkEmailQuery);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                response.sendRedirect("register.jsp?error=Email already exists! Please use a different email.");
                return;
            }
            
            rs.close();
            pstmt.close();
            
            String checkLicenseQuery = "SELECT licenseNumber FROM customers WHERE licenseNumber = ?";
            pstmt = conn.prepareStatement(checkLicenseQuery);
            pstmt.setString(1, licenseNumber);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                response.sendRedirect("register.jsp?error=License number already exists! Please check your license number.");
                return;
            }
            
            rs.close();
            pstmt.close();
            
            String hashedPassword = hashPassword(password);
            
            String customerName = firstName.trim() + " " + lastName.trim();
            
            String insertQuery = "INSERT INTO customers (customerName, email, password, phone, address, licenseNumber, registrationDate) VALUES (?, ?, ?, ?, ?, ?, NOW())";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, customerName);
            pstmt.setString(2, email.trim().toLowerCase());
            pstmt.setString(3, hashedPassword);
            pstmt.setString(4, phone.trim());
            pstmt.setString(5, address.trim());
            pstmt.setString(6, licenseNumber.trim().toUpperCase());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.sendRedirect("register.jsp?success=Registration successful! You can now login.");
            } else {
                response.sendRedirect("register.jsp?error=Registration failed! Please try again.");
            }
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database driver not found!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database error occurred! " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    private boolean isValidEmail(String email) {
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    }
    
    private boolean isValidPhone(String phone) {
        return phone.matches("^[\\d\\s\\-\\+\\(\\)]{10,15}$");
    }
    
    private boolean isValidAge(String dateOfBirth) {
        try {
            LocalDate birthDate = LocalDate.parse(dateOfBirth);
            LocalDate currentDate = LocalDate.now();
            return birthDate.plusYears(18).isBefore(currentDate) || birthDate.plusYears(18).isEqual(currentDate);
        } catch (Exception e) {
            return false;
        }
    }
    
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return password; 
        }
    }
}