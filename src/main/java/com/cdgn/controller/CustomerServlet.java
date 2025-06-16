package com.cdgn.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CarDao;
import model.Car;

@WebServlet("/customer")
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            loadCustomerDashboard(request, response);
        } else {
            switch (action) {
                case "viewAvailable":
                    viewAvailableCars(request, response);
                    break;
                case "searchCars":
                    searchCars(request, response);
                    break;
                
                default:
                    loadCustomerDashboard(request, response);
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void loadCustomerDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CarDao dao = new CarDao();
        try {
            List<Car> availableCarList = dao.viewAvailableCars();
            request.setAttribute("availableCarList", availableCarList);
            
            request.setAttribute("totalAvailableCars", availableCarList.size());
            
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            String userType = (String) session.getAttribute("userType");
            
            request.setAttribute("username", username);
            request.setAttribute("userType", userType);
            
            RequestDispatcher rd = request.getRequestDispatcher("customer.jsp");
            rd.forward(request, response);
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load dashboard. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
            rd.forward(request, response);
        }
    }

    private void viewAvailableCars(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CarDao dao = new CarDao();
        try {
            List<Car> availableCarList = dao.viewAvailableCars();
            request.setAttribute("availableCarList", availableCarList);
            
            RequestDispatcher rd = request.getRequestDispatcher("viewAvailableCars.jsp");
            rd.forward(request, response);
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to fetch available cars. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
            rd.forward(request, response);
        }
    }

    private void searchCars(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        
        if (searchValue == null || searchValue.trim().isEmpty()) {
            request.setAttribute("status", "Please enter a search value.");
            RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
            rd.forward(request, response);
            return;
        }
        
        CarDao dao = new CarDao();
        try {
            if ("brand".equals(searchType)) {
                List<Car> carList = dao.searchCarsByBrand(searchValue);
                if (!carList.isEmpty()) {
                    request.setAttribute("carList", carList);
                    request.setAttribute("searchBrand", searchValue);
                    RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
                    rd.forward(request, response);
                } else {
                    request.setAttribute("status", "No available cars found for brand: " + searchValue);
                    RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
                    rd.forward(request, response);
                }
            } else if ("id".equals(searchType)) {
                try {
                    int carId = Integer.parseInt(searchValue);
                    Car car = dao.searchCar(carId);
                    if (car.getCarId() != 0 && "Available".equals(car.getAvailabilityStatus())) {
                        request.setAttribute("car", car);
                        RequestDispatcher rd = request.getRequestDispatcher("viewCar.jsp");
                        rd.forward(request, response);
                    } else {
                        request.setAttribute("status", "No available car found with ID: " + carId);
                        RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
                        rd.forward(request, response);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("status", "Invalid Car ID format. Please enter a valid number.");
                    RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
                    rd.forward(request, response);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "Search failed. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
            rd.forward(request, response);
        }
    }
}

   