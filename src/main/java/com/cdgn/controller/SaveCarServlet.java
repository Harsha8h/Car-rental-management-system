package com.cdgn.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CarDao;
import model.Car;


@SuppressWarnings("serial")
@WebServlet("/saveCar")
public class SaveCarServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Car car = new Car();
        car.setCarId(Integer.parseInt(request.getParameter("carId")));
        car.setCarName(request.getParameter("carName"));
        car.setBrand(request.getParameter("brand"));
        car.setModel(request.getParameter("model"));
        car.setYear(Integer.parseInt(request.getParameter("year")));
        car.setColor(request.getParameter("color"));
        car.setRentalPrice(Double.parseDouble(request.getParameter("rentalPrice")));
        car.setFuelType(request.getParameter("fuelType"));
        car.setSeatingCapacity(Integer.parseInt(request.getParameter("seatingCapacity")));
        car.setTransmissionType(request.getParameter("transmissionType"));
        car.setAvailabilityStatus("Available"); 
        
        CarDao dao = new CarDao();
        try {
            boolean status = dao.saveCar(car);
            RequestDispatcher rd = request.getRequestDispatcher("addCar.jsp");
            if (status) {
                dao.commit();
                request.setAttribute("status", "Car added successfully!");
                rd.forward(request, response);
            } else {
                dao.rollback();
                request.setAttribute("status", "Failed to add car. Please try again.");
                rd.forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "System error occurred. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("addCar.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}