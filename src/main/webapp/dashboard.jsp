<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.qkl.entity.User" %>

<%User currentUser = (User) session.getAttribute("user");

    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    boolean isManager = "Manager".equals(currentUser.getRole());%>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dashboard - Quản Lý Kho</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/home">

            Trang chủ

        </a>

        <div class="d-flex align-items-center">

            <span class="text-white  me-3">
                <strong>
                    <%= currentUser.getFullName() %>
                </strong>

                <span class="badge bg-warning text-dark ms-2">
                    <%= currentUser.getRole() %>
                </span>

            </span>

            <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-light btn-sm">

                Đăng xuất

            </a>

        </div>

    </div>

</nav>

<!-- CONTENT -->
<div class="container mt-4">

    <h2 class="mb-1">Dashboard</h2>

    <p class="text-muted mb-4">
        Quản lý hệ thống kho hàng </p>

    <div class="row g-4">

        <!-- PRODUCT -->
        <div class="col-md-4">

            <div class="card shadow-sm h-100">

                <div class="card-body">

                    <h5 class="card-title">
                        Sản phẩm </h5>

                    <p class="card-text text-muted">
                        Quản lý thông tin sản phẩm. </p>

                    <a href="<%= request.getContextPath() %>/product" class="btn btn-secondary"> Quản lý </a>

                </div>

            </div>

        </div>

        <% if (isManager) { %>

        <!-- CATEGORY -->
        <div class="col-md-4">

            <div class="card shadow-sm h-100">

                <div class="card-body">

                    <h5 class="card-title">
                        Danh mục </h5>

                    <p class="card-text text-muted">
                        Quản lý danh mục sản phẩm. </p>

                    <a href="<%= request.getContextPath() %>/category" class="btn btn-secondary"> Quản lý </a>

                </div>

            </div>

        </div>

        <!-- BRAND -->
        <div class="col-md-4">

            <div class="card shadow-sm h-100">

                <div class="card-body">

                    <h5 class="card-title">
                        Thương hiệu </h5>

                    <p class="card-text text-muted">
                        Quản lý thương hiệu. </p>

                    <a href="<%= request.getContextPath() %>/brand" class="btn btn-secondary"> Quản lý </a>

                </div>

            </div>

        </div>

        <!-- SUPPLIER -->
        <div class="col-md-4">

            <div class="card shadow-sm h-100">

                <div class="card-body">

                    <h5 class="card-title">
                        Nhà cung cấp </h5>

                    <p class="card-text text-muted">
                        Quản lý nhà cung cấp. </p>

                    <a href="<%= request.getContextPath() %>/supplier" class="btn btn-secondary"> Quản lý </a>

                </div>

            </div>

        </div>

        <!-- USER -->
        <div class="col-md-4">

            <div class="card shadow-sm h-100">

                <div class="card-body">

                    <h5 class="card-title">
                        Nhân viên </h5>

                    <p class="card-text text-muted">
                        Quản lý tài khoản nhân viên. </p>

                    <a href="<%= request.getContextPath() %>/user" class="btn btn-secondary"> Quản lý </a>

                </div>

            </div>

        </div>

        <% } %>

        <!-- INVENTORY -->
        <div class="col-md-4">

            <div class="card shadow-sm h-100">

                <div class="card-body">

                    <h5 class="card-title">
                        Tồn kho </h5>

                    <p class="card-text text-muted">
                        Xem tình trạng tồn kho. </p>

                    <a href="<%= request.getContextPath() %>/inventory" class="btn btn-secondary"> Quản lý </a>

                </div>

            </div>

        </div>

        <!-- IMPORT RECEIPT -->
        <div class="col-md-4">

            <div class="card shadow-sm h-100">

                <div class="card-body">

                    <h5 class="card-title">
                        Nhập hàng </h5>

                    <p class="card-text text-muted">
                        Quản lý phiếu nhập kho. </p>

                    <a href="<%= request.getContextPath() %>/import" class="btn btn-secondary"> Quản lý </a>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>