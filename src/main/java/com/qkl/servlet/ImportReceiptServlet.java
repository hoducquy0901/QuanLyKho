package com.qkl.servlet;

import com.qkl.dao.*;
import com.qkl.dao.impl.*;

import com.qkl.entity.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/import")
public class ImportReceiptServlet extends HttpServlet {

    private ImportReceiptDAO receiptDAO = new ImportReceiptDAOImpl();

    private SupplierDAO supplierDAO = new SupplierDAOImpl();
    private ImportReceiptDetailDAO detailDAO = new ImportReceiptDetailDAOImpl();

    private ProductDAO productDAO = new ProductDAOImpl();

    private InventoryDAO inventoryDAO = new InventoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Kiểm tra đăng nhập
        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;
        }


        // Lấy danh sách phiếu nhập
        List<ImportReceipt> receipts = receiptDAO.findAll();
        String sort = request.getParameter("sort");

        if ("totalAsc".equals(sort)) {

            receipts.sort((r1, r2) -> Double.compare(r1.getTotalAmount() != null ? r1.getTotalAmount() : 0.0, r2.getTotalAmount() != null ? r2.getTotalAmount() : 0.0));

        } else if ("totalDesc".equals(sort)) {

            receipts.sort((r1, r2) -> Double.compare(r2.getTotalAmount() != null ? r2.getTotalAmount() : 0.0, r1.getTotalAmount() != null ? r1.getTotalAmount() : 0.0));
        }

        // Lấy danh sách nhà cung cấp
        List<Supplier> suppliers = supplierDAO.findAll();
        List<Product> products = productDAO.findAll();
        List<ImportReceiptDetail> details = detailDAO.findAll();
        request.setAttribute("receipts", receipts);

        request.setAttribute("suppliers", suppliers);
        request.setAttribute("products", products);
        request.setAttribute("details", details);


        request.getRequestDispatcher("/importreceipt.jsp").forward(request, response);
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
        if ("delete".equals(action) && !"Manager".equals(currentUser.getRole())) {

            response.sendRedirect(request.getContextPath() + "/import");

            return;
        }

        // ==============================
        // THÊM PHIẾU NHẬP
        // ==============================

        if ("create".equals(action)) {

            ImportReceipt receipt = new ImportReceipt();


            // Ngày nhập
            receipt.setImportDate(new Date());


            // Nhà cung cấp
            Integer supplierId = Integer.parseInt(request.getParameter("supplierId"));


            Supplier supplier = supplierDAO.findById(supplierId);


            receipt.setSupplier(supplier);


            // Người nhập
            receipt.setUser(currentUser);
            // Người nhập
            receipt.setUser(currentUser);


// Số lượng
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));


// Đơn giá
            Double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));


// Tính tổng tiền
            receipt.setTotalAmount(quantity * unitPrice);


            receiptDAO.create(receipt);


// ==============================
// THÊM CHI TIẾT PHIẾU NHẬP
// ==============================

            Integer productId = Integer.parseInt(request.getParameter("productId"));


            Product product = productDAO.findById(productId);


            ImportReceiptDetail detail = new ImportReceiptDetail();

            detail.setReceipt(receipt);
            detail.setProduct(product);
            detail.setQuantity(quantity);
            detail.setUnitPrice(unitPrice);


            detailDAO.create(detail);
            // ==============================
// CẬP NHẬT TỒN KHO
// ==============================

            Inventory inventory = null;

            for (Inventory item : inventoryDAO.findAll()) {

                if (item.getProduct() != null && item.getProduct().getProductId().equals(productId)) {

                    inventory = item;
                    break;
                }
            }


            if (inventory != null) {

                inventory.setQuantity(inventory.getQuantity() + quantity);

                inventory.setLastUpdated(new Date());

                inventoryDAO.update(inventory);

            } else {

                inventory = new Inventory();

                inventory.setProduct(product);
                inventory.setQuantity(quantity);
                inventory.setLastUpdated(new Date());

                inventoryDAO.create(inventory);
            }
        }


        // ==============================
// SỬA PHIẾU NHẬP
// ==============================

        else if ("update".equals(action)) {

            Integer receiptId = Integer.parseInt(request.getParameter("receiptId"));

            ImportReceipt receipt = receiptDAO.findById(receiptId);


            if (receipt != null) {

                // ==============================
                // SỬA NHÀ CUNG CẤP
                // ==============================

                Integer supplierId = Integer.parseInt(request.getParameter("supplierId"));

                Supplier supplier = supplierDAO.findById(supplierId);

                receipt.setSupplier(supplier);


                // ==============================
                // LẤY CHI TIẾT PHIẾU NHẬP
                // ==============================

                Integer detailId = Integer.parseInt(request.getParameter("detailId"));

                ImportReceiptDetail detail = detailDAO.findById(detailId);


                if (detail != null) {

                    // Số lượng cũ
                    Integer oldQuantity = detail.getQuantity();


                    // Số lượng mới
                    Integer newQuantity = Integer.parseInt(request.getParameter("quantity"));


                    // Đơn giá mới
                    Double newUnitPrice = Double.parseDouble(request.getParameter("unitPrice"));
                    // Tính lại tổng tiền
                    receipt.setTotalAmount(newQuantity * newUnitPrice);


                    // ==============================
                    // CẬP NHẬT CHI TIẾT
                    // ==============================

                    detail.setQuantity(newQuantity);

                    detail.setUnitPrice(newUnitPrice);

                    detailDAO.update(detail);


                    // ==============================
                    // CẬP NHẬT TỒN KHO
                    // ==============================

                    Integer difference = newQuantity - oldQuantity;


                    Inventory inventory = null;

                    for (Inventory item : inventoryDAO.findAll()) {

                        if (item.getProduct() != null && item.getProduct().getProductId().equals(detail.getProduct().getProductId())) {

                            inventory = item;

                            break;
                        }
                    }


                    if (inventory != null) {

                        inventory.setQuantity(inventory.getQuantity() + difference);

                        inventory.setLastUpdated(new Date());

                        inventoryDAO.update(inventory);
                    }
                }


                // ==============================
                // LƯU PHIẾU NHẬP
                // ==============================

                receiptDAO.update(receipt);
            }
        }


// ==============================
// XÓA PHIẾU NHẬP
// ==============================

        else if ("delete".equals(action)) {

            Integer receiptId = Integer.parseInt(request.getParameter("receiptId"));


            // Lấy phiếu nhập
            ImportReceipt receipt = receiptDAO.findById(receiptId);


            if (receipt != null) {

                // Lấy danh sách chi tiết của phiếu
                List<ImportReceiptDetail> details = detailDAO.findAll();


                for (ImportReceiptDetail detail : details) {

                    // Chỉ xử lý detail thuộc phiếu đang xóa
                    if (detail.getReceipt() != null && detail.getReceipt().getReceiptId().equals(receiptId)) {


                        // ==============================
                        // TRỪ TỒN KHO
                        // ==============================

                        Product product = detail.getProduct();

                        Integer quantity = detail.getQuantity();


                        Inventory inventory = null;


                        for (Inventory item : inventoryDAO.findAll()) {

                            if (item.getProduct() != null && item.getProduct().getProductId().equals(product.getProductId())) {

                                inventory = item;

                                break;
                            }
                        }


                        if (inventory != null) {

                            inventory.setQuantity(inventory.getQuantity() - quantity);

                            inventory.setLastUpdated(new Date());

                            inventoryDAO.update(inventory);
                        }


                        // ==============================
                        // XÓA CHI TIẾT
                        // ==============================

                        detailDAO.delete(detail.getDetailId());
                    }
                }


                // ==============================
                // XÓA PHIẾU NHẬP
                // ==============================

                receiptDAO.delete(receiptId);
            }
        }


        // Quay lại trang
        response.sendRedirect(request.getContextPath() + "/import");
    }
}