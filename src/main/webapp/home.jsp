<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.qkl.entity.Product" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Home - Quản Lý Kho</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">

        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/home"> Trang chủ </a>

        <div class="d-flex align-items-center">

            <%Object userObj = session.getAttribute("user");
                if (userObj != null) {
                    com.qkl.entity.User currentUser = (com.qkl.entity.User) userObj;%>

            <span class="text-white me-3">
    Xin chào,
    <strong><%= currentUser.getFullName() %></strong>

    <span class="badge bg-warning text-dark ms-2">
        <%= currentUser.getRole() %>
    </span>
</span>

            <%}%>
            <a href="<%= request.getContextPath() %>/change-password" class="btn btn-outline-light btn-sm me-2"> Đổi mật
                khẩu </a> <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-light btn-sm"> Đăng
            xuất </a>

        </div>
    </div>
</nav>

<div class="container-fluid mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">

        <div>
            <h3 class="mb-1">Danh sách kho</h3>
        </div>

        <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-primary"> Quản lý hệ thống </a>

    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-bordered mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th class="text-center">STT</th>
                        <th>Sản phẩm</th>
                        <th>Thương hiệu</th>
                        <th>Danh mục</th>
                        <th>Đơn vị</th>
                        <th class="text-end">Giá nhập</th>
                        <th class="text-end">Giá bán</th>
                        <th class="text-center">Tồn kho</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%List<Product> products =
                            (List<Product>) request.getAttribute("products");

                        NumberFormat moneyFormat =
                                NumberFormat.getNumberInstance(Locale.US);

                        moneyFormat.setMaximumFractionDigits(0);

                        if (products != null && !products.isEmpty()) {

                            int stt = 1;

                            for (Product p : products) {%>

                    <tr>

                        <td class="text-center">
                            <%= stt++ %>
                        </td>

                        <td>
                            <strong>
                                <%= p.getProductName() %>
                            </strong>
                        </td>

                        <td>
                            <%= p.getBrand() != null
                                    ? p.getBrand().getBrandName()
                                    : "" %>
                        </td>

                        <td>
                            <%= p.getCategory() != null
                                    ? p.getCategory().getCategoryName()
                                    : "" %>
                        </td>

                        <td>
                            <%= p.getUnit() != null
                                    ? p.getUnit()
                                    : "" %>
                        </td>

                        <td class="text-end">
                            <%= p.getImportPrice() != null
                                    ? moneyFormat.format(p.getImportPrice())
                                    : "0" %>
                        </td>

                        <td class="text-end">
                            <%= p.getSellingPrice() != null
                                    ? moneyFormat.format(p.getSellingPrice())
                                    : "0" %>
                        </td>

                        <td class="text-center">

                            <%if (p.getInventory() != null) {%>

                            <%= p.getInventory().getQuantity() %>

                            <%} else {%>

                            0

                            <%}%>

                        </td>

                    </tr>

                    <%}

                    } else {%>

                    <tr>

                        <td colspan="8" class="text-center py-4 text-muted">

                            Chưa có sản phẩm nào.

                        </td>

                    </tr>

                    <%}%>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>