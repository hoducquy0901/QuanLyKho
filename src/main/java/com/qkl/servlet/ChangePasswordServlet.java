package com.qkl.servlet;

import com.qkl.dao.UserDAO;
import com.qkl.dao.impl.UserDAOImpl;
import com.qkl.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");

        String newPassword = request.getParameter("newPassword");

        String confirmPassword = request.getParameter("confirmPassword");


        // Kiểm tra mật khẩu hiện tại
        if (!currentUser.getPassword().equals(currentPassword)) {

            request.setAttribute("message", "Mật khẩu hiện tại không đúng!");

            request.getRequestDispatcher("/change-password.jsp").forward(request, response);

            return;
        }


        // Kiểm tra mật khẩu mới
        if (newPassword == null || newPassword.trim().isEmpty()) {

            request.setAttribute("message", "Mật khẩu mới không được để trống!");

            request.getRequestDispatcher("/change-password.jsp").forward(request, response);

            return;
        }


        // Kiểm tra xác nhận mật khẩu
        if (!newPassword.equals(confirmPassword)) {

            request.setAttribute("message", "Mật khẩu mới không trùng nhau!");

            request.getRequestDispatcher("/change-password.jsp").forward(request, response);

            return;
        }


        // Không cho đặt lại mật khẩu cũ
        if (currentPassword.equals(newPassword)) {

            request.setAttribute("message", "Mật khẩu mới phải khác mật khẩu cũ!");

            request.getRequestDispatcher("/change-password.jsp").forward(request, response);

            return;
        }


        // Cập nhật mật khẩu
        currentUser.setPassword(newPassword);

        userDAO.update(currentUser);


        // Cập nhật lại session
        request.getSession().setAttribute("user", currentUser);

        request.setAttribute("success", "Đổi mật khẩu thành công!");

        request.getRequestDispatcher("/change-password.jsp").forward(request, response);
    }
}