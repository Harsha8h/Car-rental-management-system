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


@WebServlet("/updateCar")
public class UpdateCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
        car.setAvailabilityStatus(request.getParameter("availabilityStatus"));
        
        CarDao dao = new CarDao();
        try {
            boolean status = dao.updateCar(car);
            if (status) {
                dao.commit();
                request.setAttribute("status", "Car updated successfully!");
                request.setAttribute("car", car);
                RequestDispatcher rd = request.getRequestDispatcher("editCar.jsp");
                rd.forward(request, response);
            } else {
                dao.rollback();
                request.setAttribute("status", "Update failed. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("editCar.jsp");
                rd.forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "System error occurred. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("editCar.jsp");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}