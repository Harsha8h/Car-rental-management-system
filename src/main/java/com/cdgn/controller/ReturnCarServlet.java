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


@WebServlet("/returnCar")
public class ReturnCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int carId = Integer.parseInt(request.getParameter("carId"));
        CarDao dao = new CarDao();
        try {
            boolean status = dao.returnCar(carId);
            if (status) {
                dao.commit();
                request.setAttribute("status", "Car returned successfully!");
                request.setAttribute("carId", carId);
                RequestDispatcher rd = request.getRequestDispatcher("returnConfirmation.jsp");
                rd.forward(request, response);
            } else {
                dao.rollback();
                request.setAttribute("status", "Failed to return car. Please contact support.");
                RequestDispatcher rd = request.getRequestDispatcher("viewAllCars");
                rd.forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "System error occurred. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("viewAllCars");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}