package com.cdgn.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CarDao;

@SuppressWarnings("serial")
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession(true);
        
        if (username.equals("admin@carrental.com") && password.equals("admin@cr")) {
            session.setAttribute("username", username);
            session.setAttribute("userType", "admin");
            response.sendRedirect("admin.jsp");
        } else {
        	
            CarDao dao = new CarDao();
            try {
                boolean status = dao.checkCustomerLogin(username, password);
                if (status) {
                    session.setAttribute("username", username);
                    session.setAttribute("userType", "customer");
                    response.sendRedirect("customer");
                } else {
                    request.setAttribute("status", "Invalid Credentials");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                request.setAttribute("status", "System Error. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}