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


@WebServlet("/deleteCar")
public class DeleteCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int carId = Integer.parseInt(request.getParameter("carId"));
        CarDao dao = new CarDao();
        try {
            boolean status = dao.deleteById(carId);
            if (status) {
                dao.commit();
                response.sendRedirect("viewAllCars");
            } else {
                dao.rollback();
                request.setAttribute("error", "Failed to delete car with ID: " + carId);
                RequestDispatcher rd = request.getRequestDispatcher("viewAllCars");
                rd.forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "System error occurred while deleting car.");
            RequestDispatcher rd = request.getRequestDispatcher("viewAllCars");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}