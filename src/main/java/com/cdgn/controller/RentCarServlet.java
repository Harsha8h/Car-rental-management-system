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


@WebServlet("/rentCar")
public class RentCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int carId = Integer.parseInt(request.getParameter("carId"));
        CarDao dao = new CarDao();
        try {
            boolean status = dao.rentCar(carId);
            if (status) {
                dao.commit();
                request.setAttribute("status", "Car rented successfully!");
                request.setAttribute("carId", carId);
                RequestDispatcher rd = request.getRequestDispatcher("rentalConfirmation.jsp");
                rd.forward(request, response);
            } else {
                dao.rollback();
                request.setAttribute("status", "Failed to rent car. It may no longer be available.");
                RequestDispatcher rd = request.getRequestDispatcher("viewAvailableCars");
                rd.forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "System error occurred. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("viewAvailableCars");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}