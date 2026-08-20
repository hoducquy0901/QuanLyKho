package com.qkl.servlet;

import com.qkl.dao.BrandDAO;
import com.qkl.dao.impl.BrandDAOImpl;
import com.qkl.entity.Brand;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/brand")
public class BrandServlet extends HttpServlet {

    private BrandDAO dao = new BrandDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Brand> list = dao.findAll();

        request.setAttribute("list", list);

        request.getRequestDispatcher("/brand.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("create".equals(action)) {

            Brand brand = new Brand();

            brand.setBrandName(request.getParameter("brandName"));
            brand.setCountry(request.getParameter("country"));
            brand.setDescription(request.getParameter("description"));

            dao.create(brand);

        } else if ("update".equals(action)) {

            Brand brand = new Brand();

            brand.setBrandId(Integer.parseInt(request.getParameter("brandId")));

            brand.setBrandName(request.getParameter("brandName"));
            brand.setCountry(request.getParameter("country"));
            brand.setDescription(request.getParameter("description"));

            dao.update(brand);

        } else if ("delete".equals(action)) {

            Integer id = Integer.parseInt(
                    request.getParameter("brandId")
            );

            if (dao.hasProducts(id)) {

                request.getSession().setAttribute(
                        "error",
                        "Không thể xóa thương hiệu vì đang có sản phẩm sử dụng thương hiệu này!"
                );

            } else {

                dao.delete(id);

                request.getSession().setAttribute(
                        "success",
                        "Xóa thương hiệu thành công!"
                );
            }

        response.sendRedirect(request.getContextPath() + "/brand");
    }
}
}