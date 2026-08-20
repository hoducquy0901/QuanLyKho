package com.qkl.servlet;

import com.qkl.dao.CategoryDAO;
import com.qkl.dao.impl.CategoryDAOImpl;
import com.qkl.entity.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    private CategoryDAO dao = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> list = dao.findAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/category.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("create".equals(action)) {
            Category c = new Category();
            c.setCategoryName(request.getParameter("categoryName"));
            dao.create(c);
        } else if ("update".equals(action)) {
            Category c = new Category();
            c.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            c.setCategoryName(request.getParameter("categoryName"));
            dao.update(c);
        } else if ("delete".equals(action)) {

            Integer id = Integer.parseInt(request.getParameter("categoryId"));

            if (dao.hasProducts(id)) {

                request.getSession().setAttribute("error", "Không thể xóa danh mục vì đang có sản phẩm sử dụng danh mục này!");

            } else {

                dao.delete(id);

                request.getSession().setAttribute("success", "Xóa danh mục thành công!");
            }
            response.sendRedirect("category");
        }
    }
}