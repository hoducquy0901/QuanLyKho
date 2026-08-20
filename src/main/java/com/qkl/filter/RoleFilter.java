package com.qkl.filter;

import com.qkl.entity.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/category/*", "/brand/*", "/supplier/*", "/user/*", "/product/create", "/product/edit/*", "/product/delete/*"})
public class RoleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        // Chưa đăng nhập
        if (session == null || session.getAttribute("user") == null) {

            resp.sendRedirect(req.getContextPath() + "/login");

            return;
        }

        User user = (User) session.getAttribute("user");

        // Chỉ Manager được truy cập
        if (!"Manager".equals(user.getRole())) {

            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập chức năng này.");

            return;
        }

        // Có quyền
        chain.doFilter(request, response);
    }
}