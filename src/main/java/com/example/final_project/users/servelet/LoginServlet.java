package com.example.final_project.users.servelet;


import com.example.final_project.users.dto.UserDto;
import com.example.final_project.users.service.AuthenticationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private AuthenticationService authService = new AuthenticationService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDto user = authService.authenticate(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin/dashboard.jsp");
            } else if ("cashier".equals(user.getRole())) {
                response.sendRedirect("cashier/dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=role");
            }
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
