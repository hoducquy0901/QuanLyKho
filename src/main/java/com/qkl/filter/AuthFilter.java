package com.qkl.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;

        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // Các trang được phép truy cập khi chưa đăng nhập
        if (uri.endsWith("/login") || uri.endsWith("/login.jsp") || uri.endsWith("/forgot-password") || uri.endsWith("/forgot-password.jsp")) {

            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra đăng nhập
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("user") != null) {

            chain.doFilter(request, response);

        } else {

            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}