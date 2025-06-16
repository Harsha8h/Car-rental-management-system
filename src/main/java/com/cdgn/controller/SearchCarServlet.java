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

import dao.CarDao;
import model.Car;


@SuppressWarnings("serial")
@WebServlet("/searchCar")
public class SearchCarServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        
        CarDao dao = new CarDao();
        try {
            if ("id".equals(searchType)) {
                int carId = Integer.parseInt(searchValue);
                Car car = dao.searchCar(carId);
                if (car.getCarId() != 0) {
                    request.setAttribute("car", car);
                    RequestDispatcher rd = request.getRequestDispatcher("viewCar.jsp");
                    rd.forward(request, response);
                } else {
                    request.setAttribute("status", "No car found with ID: " + carId);
                    RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
                    rd.forward(request, response);
                }
            } else if ("brand".equals(searchType)) {
                List<Car> carList = dao.searchCarsByBrand(searchValue);
                if (!carList.isEmpty()) {
                    request.setAttribute("carList", carList);
                    request.setAttribute("searchBrand", searchValue);
                    RequestDispatcher rd = request.getRequestDispatcher("searchResults.jsp");
                    rd.forward(request, response);
                } else {
                    request.setAttribute("status", "No cars found for brand: " + searchValue);
                    RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
                    rd.forward(request, response);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "Search failed. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
            rd.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("status", "Invalid Car ID format. Please enter a valid number.");
            RequestDispatcher rd = request.getRequestDispatcher("searchCar.jsp");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}