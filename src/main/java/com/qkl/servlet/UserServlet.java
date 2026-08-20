package com.qkl.servlet;

import com.qkl.dao.UserDAO;
import com.qkl.dao.impl.UserDAOImpl;
import com.qkl.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private UserDAO dao = new UserDAOImpl();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // ==============================
        // KIỂM TRA ĐĂNG NHẬP
        // ==============================

        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;
        }


        // ==============================
        // CHỈ MANAGER ĐƯỢC QUẢN LÝ USER
        // ==============================

        if (!"Manager".equals(currentUser.getRole())) {

            response.sendRedirect(request.getContextPath() + "/dashboard");

            return;
        }


        // ==============================
        // LẤY DANH SÁCH USER
        // ==============================

        List<User> list = dao.findAll();

        request.setAttribute("list", list);


        request.getRequestDispatcher("/user.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


        // ==============================
        // KIỂM TRA ĐĂNG NHẬP
        // ==============================

        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;
        }


        // ==============================
        // CHỈ MANAGER
        // ==============================

        if (!"Manager".equals(currentUser.getRole())) {

            response.sendRedirect(request.getContextPath() + "/dashboard");

            return;
        }


        String action = request.getParameter("action");


        // ==============================
        // THÊM USER
        // ==============================

        if ("create".equals(action)) {

            User user = new User();

            user.setFullName(request.getParameter("fullName"));

            user.setEmail(request.getParameter("email"));

            user.setPhone(request.getParameter("phone"));

            user.setUsername(request.getParameter("username"));

            user.setPassword(request.getParameter("password"));

            user.setRole(request.getParameter("role"));

            dao.create(user);
        }


        // ==============================
        // SỬA USER
        // ==============================

        else if ("update".equals(action)) {

            Integer usersId = Integer.parseInt(request.getParameter("usersId"));

            User user = dao.findById(usersId);


            if (user != null) {

                user.setFullName(request.getParameter("fullName"));

                user.setEmail(request.getParameter("email"));

                user.setPhone(request.getParameter("phone"));

                user.setUsername(request.getParameter("username"));

                user.setPassword(request.getParameter("password"));

                user.setRole(request.getParameter("role"));

                dao.update(user);
            }
        }


        // ==============================
        // XÓA USER
        // ==============================

        else if ("delete".equals(action)) {

            Integer usersId = Integer.parseInt(request.getParameter("usersId"));


            // Không cho tự xóa tài khoản
            if (currentUser.getUsersId() != null && currentUser.getUsersId().equals(usersId)) {

                response.sendRedirect(request.getContextPath() + "/user");

                return;
            }


            dao.delete(usersId);
        }


        // ==============================
        // QUAY LẠI
        // ==============================

        response.sendRedirect(request.getContextPath() + "/user");
    }
}