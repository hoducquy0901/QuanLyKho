package com.qkl.servlet;

import com.qkl.dao.ProductDAO;
import com.qkl.dao.impl.ProductDAOImpl;
import com.qkl.dao.BrandDAO;
import com.qkl.dao.impl.BrandDAOImpl;
import com.qkl.dao.CategoryDAO;
import com.qkl.dao.impl.CategoryDAOImpl;

import com.qkl.entity.Product;
import com.qkl.entity.Brand;
import com.qkl.entity.Category;
import com.qkl.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAOImpl();
    private BrandDAO brandDAO = new BrandDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Kiểm tra đăng nhập
        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;
        }


        // Lấy danh sách sản phẩm
        List<Product> products = productDAO.findAll();

        String sort = request.getParameter("sort");

        if ("importAsc".equals(sort)) {

            products.sort((p1, p2) -> Double.compare(p1.getImportPrice(), p2.getImportPrice()));

        } else if ("importDesc".equals(sort)) {

            products.sort((p1, p2) -> Double.compare(p2.getImportPrice(), p1.getImportPrice()));

        } else if ("sellingAsc".equals(sort)) {

            products.sort((p1, p2) -> Double.compare(p1.getSellingPrice(), p2.getSellingPrice()));

        } else if ("sellingDesc".equals(sort)) {

            products.sort((p1, p2) -> Double.compare(p2.getSellingPrice(), p1.getSellingPrice()));

        } else if ("inventoryAsc".equals(sort)) {

            products.sort((p1, p2) -> Integer.compare(p1.getInventory() != null ? p1.getInventory().getQuantity() : 0,

                    p2.getInventory() != null ? p2.getInventory().getQuantity() : 0));

        } else if ("inventoryDesc".equals(sort)) {

            products.sort((p1, p2) -> Integer.compare(p2.getInventory() != null ? p2.getInventory().getQuantity() : 0,

                    p1.getInventory() != null ? p1.getInventory().getQuantity() : 0));
        }


        // Lấy danh sách thương hiệu
        List<Brand> brands = brandDAO.findAll();


        // Lấy danh sách danh mục
        List<Category> categories = categoryDAO.findAll();


        request.setAttribute("list", products);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);


        request.getRequestDispatcher("/product.jsp").forward(request, response);
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


        String action = request.getParameter("action");


        // ==========================================
        // EMPLOYEE KHÔNG ĐƯỢC THÊM / SỬA / XÓA
        // ==========================================

        if (!"Manager".equals(currentUser.getRole())) {

            response.sendRedirect(request.getContextPath() + "/product");

            return;
        }


        // ==========================================
        // THÊM SẢN PHẨM
        // ==========================================

        if ("create".equals(action)) {

            Product product = new Product();


            product.setProductName(request.getParameter("productName"));


            Integer brandId = Integer.parseInt(request.getParameter("brandId"));


            Integer categoryId = Integer.parseInt(request.getParameter("categoryId"));


            Brand brand = brandDAO.findById(brandId);


            Category category = categoryDAO.findById(categoryId);


            product.setBrand(brand);
            product.setCategory(category);


            product.setUnit(request.getParameter("unit"));


            // Lấy giá nhập
            Double importPrice = Double.parseDouble(request.getParameter("importPrice"));


            // Lấy giá bán
            Double sellingPrice = Double.parseDouble(request.getParameter("sellingPrice"));


            // ==========================================
            // KHÔNG CHO PHÉP GIÁ ÂM
            // ==========================================

            if (importPrice < 0 || sellingPrice < 0) {

                request.setAttribute("message", "Giá nhập và giá bán không được nhỏ hơn 0!");

                // Gửi lại dữ liệu cần thiết cho JSP
                request.setAttribute("list", productDAO.findAll());

                request.setAttribute("brands", brandDAO.findAll());

                request.setAttribute("categories", categoryDAO.findAll());

                request.getRequestDispatcher("/product.jsp").forward(request, response);

                return;
            }


            product.setImportPrice(importPrice);

            product.setSellingPrice(sellingPrice);


            product.setDescription(request.getParameter("description"));


            productDAO.create(product);
        }


        // ==========================================
        // SỬA SẢN PHẨM
        // ==========================================

        else if ("update".equals(action)) {

            Product product = new Product();


            product.setProductId(Integer.parseInt(request.getParameter("productId")));


            product.setProductName(request.getParameter("productName"));


            Integer brandId = Integer.parseInt(request.getParameter("brandId"));


            Integer categoryId = Integer.parseInt(request.getParameter("categoryId"));


            Brand brand = brandDAO.findById(brandId);


            Category category = categoryDAO.findById(categoryId);


            product.setBrand(brand);
            product.setCategory(category);


            product.setUnit(request.getParameter("unit"));


            // Lấy giá nhập
            Double importPrice = Double.parseDouble(request.getParameter("importPrice"));


            // Lấy giá bán
            Double sellingPrice = Double.parseDouble(request.getParameter("sellingPrice"));


            // ==========================================
            // KHÔNG CHO PHÉP GIÁ ÂM
            // ==========================================

            if (importPrice < 0 || sellingPrice < 0) {

                request.setAttribute("message", "Giá nhập và giá bán không được nhỏ hơn 0!");

                // Gửi lại dữ liệu cần thiết cho JSP
                request.setAttribute("list", productDAO.findAll());

                request.setAttribute("brands", brandDAO.findAll());

                request.setAttribute("categories", categoryDAO.findAll());

                request.getRequestDispatcher("/product.jsp").forward(request, response);

                return;
            }


            product.setImportPrice(importPrice);

            product.setSellingPrice(sellingPrice);


            product.setDescription(request.getParameter("description"));


            productDAO.update(product);
        }


        // ==========================================
        // XÓA SẢN PHẨM
        // ==========================================

        else if ("delete".equals(action)) {

            Integer id = Integer.parseInt(request.getParameter("productId"));

            try {

                productDAO.delete(id);

                // Xóa thành công
                response.sendRedirect(request.getContextPath() + "/product");

                return;

            } catch (IllegalStateException e) {

                // Không cho xóa sản phẩm đã có phiếu nhập
                request.setAttribute("message", e.getMessage());

                // Lấy lại dữ liệu cho JSP
                request.setAttribute("list", productDAO.findAll());

                request.setAttribute("brands", brandDAO.findAll());

                request.setAttribute("categories", categoryDAO.findAll());

                request.getRequestDispatcher("/product.jsp").forward(request, response);

                return;
            }
        }


        // Quay lại trang Product
        response.sendRedirect(request.getContextPath() + "/product");
    }
}