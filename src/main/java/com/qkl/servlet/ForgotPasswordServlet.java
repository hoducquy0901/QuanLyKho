package com.qkl.servlet;

import com.qkl.dao.UserDAO;
import com.qkl.dao.impl.UserDAOImpl;
import com.qkl.entity.User;
import com.qkl.utils.EmailUtil;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");


        if (email == null || email.trim().isEmpty()) {

            request.setAttribute("message", "Vui lòng nhập email.");

            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);

            return;
        }


        email = email.trim();


        // Tìm user theo email
        User user = userDAO.findByEmail(email);


        if (user == null) {

            request.setAttribute("message", "Email không tồn tại trong hệ thống.");

            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);

            return;
        }


        // ==============================
        // TẠO MẬT KHẨU MỚI
        // ==============================

        String newPassword = UUID.randomUUID().toString().substring(0, 8);


        user.setPassword(newPassword);


        // Lưu mật khẩu mới
        userDAO.update(user);


        // ==============================
        // GỬI EMAIL
        // ==============================

        try {

            String subject = "Khôi phục mật khẩu - Quản Lý Kho";

            String content = "Xin chào " + user.getFullName() + ",\n\n"

                    + "Bạn vừa yêu cầu khôi phục mật khẩu.\n\n"

                    + "Username: " + user.getUsername() + "\n"

                    + "Mật khẩu mới: " + newPassword + "\n\n"

                    + "Vui lòng đăng nhập và đổi mật khẩu " + "sau khi đăng nhập.\n\n"

                    + "Quản Lý Kho";


            EmailUtil.sendEmail(email, subject, content);


            request.setAttribute("success", "Mật khẩu mới đã được gửi vào email của bạn.");


        } catch (MessagingException e) {

            e.printStackTrace();

            request.setAttribute("message", "Không thể gửi email. Vui lòng thử lại.");
        }


        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }
}