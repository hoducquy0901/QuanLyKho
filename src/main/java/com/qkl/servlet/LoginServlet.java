package com.qkl.servlet;

import com.qkl.dao.UserDAO;
import com.qkl.dao.impl.UserDAOImpl;
import com.qkl.entity.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    UserDAO dao = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp").forward(request, response);

    }

    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("=== LoginServlet doPost ===");
        String username = request.getParameter("username");

        String password = request.getParameter("password");

        User user = dao.login(username, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);

            response.sendRedirect("home");

        } else {

            request.setAttribute("message", "Sai tài khoản hoặc mật khẩu");

            request.getRequestDispatcher("/login.jsp").forward(request, response);

        }

    }

}