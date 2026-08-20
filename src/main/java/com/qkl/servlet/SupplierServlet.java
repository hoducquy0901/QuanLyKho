package com.qkl.servlet;

import com.qkl.dao.SupplierDAO;
import com.qkl.dao.impl.SupplierDAOImpl;
import com.qkl.entity.Supplier;
import com.qkl.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/supplier")
public class SupplierServlet extends HttpServlet {

    private SupplierDAO dao = new SupplierDAOImpl();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Kiểm tra đăng nhập
        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;
        }
        // Chỉ Manager được xem Supplier
        if (!"Manager".equals(currentUser.getRole())) {

            response.sendRedirect(request.getContextPath() + "/dashboard");

            return;
        }


        // Lấy danh sách nhà cung cấp
        List<Supplier> list = dao.findAll();


        request.setAttribute("list", list);


        request.getRequestDispatcher("/supplier.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


        // Kiểm tra đăng nhập
        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;
        }


        // Chỉ Manager được thao tác Supplier
        if (!"Manager".equals(currentUser.getRole())) {

            response.sendRedirect(request.getContextPath() + "/dashboard");

            return;
        }


        String action = request.getParameter("action");


        // ==============================
        // THÊM
        // ==============================

        if ("create".equals(action)) {

            Supplier supplier = new Supplier();

            supplier.setSupplierName(request.getParameter("supplierName"));

            supplier.setAddress(request.getParameter("address"));

            supplier.setPhone(request.getParameter("phone"));

            supplier.setEmail(request.getParameter("email"));

            dao.create(supplier);
        }


        // ==============================
        // SỬA
        // ==============================

        else if ("update".equals(action)) {

            Supplier supplier = new Supplier();

            supplier.setSupplierId(Integer.parseInt(request.getParameter("supplierId")));

            supplier.setSupplierName(request.getParameter("supplierName"));

            supplier.setAddress(request.getParameter("address"));

            supplier.setPhone(request.getParameter("phone"));

            supplier.setEmail(request.getParameter("email"));

            dao.update(supplier);
        }


        // ==============================
        // XÓA
        // ==============================

        else if ("delete".equals(action)) {

            Integer id = Integer.parseInt(request.getParameter("supplierId"));

            dao.delete(id);
        }


        response.sendRedirect(request.getContextPath() + "/supplier");
    }
}