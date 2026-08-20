package com.qkl.servlet;

import com.qkl.dao.InventoryDAO;
import com.qkl.dao.impl.InventoryDAOImpl;
import com.qkl.entity.Inventory;
import com.qkl.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {

    private InventoryDAO inventoryDAO = new InventoryDAOImpl();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Kiểm tra đăng nhập
        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;
        }
        // Lấy danh sách tồn kho
        List<Inventory> list = inventoryDAO.findAll();
        String sort = request.getParameter("sort");
        if ("quantityAsc".equals(sort)) {

            list.sort((i1, i2) -> Integer.compare(i1.getQuantity() != null ? i1.getQuantity() : 0, i2.getQuantity() != null ? i2.getQuantity() : 0));

        } else if ("quantityDesc".equals(sort)) {

            list.sort((i1, i2) -> Integer.compare(i2.getQuantity() != null ? i2.getQuantity() : 0, i1.getQuantity() != null ? i1.getQuantity() : 0));

        } else if ("updatedAsc".equals(sort)) {

            list.sort((i1, i2) -> {

                if (i1.getLastUpdated() == null) return 1;
                if (i2.getLastUpdated() == null) return -1;

                return i1.getLastUpdated().compareTo(i2.getLastUpdated());
            });

        } else if ("updatedDesc".equals(sort)) {

            list.sort((i1, i2) -> {

                if (i1.getLastUpdated() == null) return 1;
                if (i2.getLastUpdated() == null) return -1;

                return i2.getLastUpdated().compareTo(i1.getLastUpdated());
            });
        }

        request.setAttribute("list", list);


        request.getRequestDispatcher("/inventory.jsp").forward(request, response);
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


        // Employee chỉ được xem
        if (!"Manager".equals(currentUser.getRole())) {

            response.sendRedirect(request.getContextPath() + "/inventory");

            return;
        }


        String action = request.getParameter("action");


        // ==========================
        // SỬA TỒN KHO
        // ==========================

        if ("update".equals(action)) {

            Integer inventoryId = Integer.parseInt(request.getParameter("inventoryId"));


            Integer quantity = Integer.parseInt(request.getParameter("quantity"));


            Inventory inventory = inventoryDAO.findById(inventoryId);


            if (inventory != null) {

                inventory.setQuantity(quantity);

                inventory.setLastUpdated(new java.util.Date());

                inventoryDAO.update(inventory);
            }
        }


        // ==========================
        // XÓA TỒN KHO
        // ==========================

        else if ("delete".equals(action)) {

            Integer inventoryId = Integer.parseInt(request.getParameter("inventoryId"));

            inventoryDAO.delete(inventoryId);
        }


        response.sendRedirect(request.getContextPath() + "/inventory");
    }
}