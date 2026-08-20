<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.qkl.entity.Brand" %>
<%@ page import="com.qkl.entity.User" %>

<%User currentUser = (User) session.getAttribute("user");

    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    List<Brand> list =
            (List<Brand>) request.getAttribute("list");%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Quản lý thương hiệu - Quản Lý Kho</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">
<%
    String error = (String) session.getAttribute("error");
    String success = (String) session.getAttribute("success");

    session.removeAttribute("error");
    session.removeAttribute("success");
%>

<% if (error != null) { %>
<div class="alert alert-danger mx-3 mt-3">
    <%= error %>
</div>
<% } %>

<% if (success != null) { %>
<div class="alert alert-success mx-3 mt-3">
    <%= success %>
</div>
<% } %>
<!-- NAVBAR -->
<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/home">

            Trang chủ

        </a>

        <div class="d-flex align-items-center">

            <span class="text-white me-3">

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
<div class="container-fluid mt-4">

    <!-- HEADER -->
    <div class="d-flex justify-content-between
                align-items-center mb-3">

        <div>

            <h3 class="mb-1">
                Brand </h3>

        </div>

        <div>

            <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-secondary me-2">

                Quản lý hệ thống

            </a>

            <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#addBrandModal">

                Thêm thương hiệu

            </button>

        </div>

    </div>

    <!-- TABLE CARD -->
    <div class="card shadow-sm">

        <div class="card-header bg-white">

            <strong> Danh sách thương hiệu </strong>

        </div>

        <div class="card-body p-0">

            <div class="table-responsive">

                <table class="table table-hover
                              table-bordered
                              mb-0">

                    <thead class="table-dark">

                    <tr>

                        <th class="text-center" style="width: 80px;">

                            STT

                        </th>

                        <th>
                            Tên thương hiệu
                        </th>

                        <th>
                            Quốc gia
                        </th>

                        <th>
                            Mô tả
                        </th>

                        <th class="text-center" style="width: 220px;">

                            Thao tác

                        </th>

                    </tr>

                    </thead>

                    <tbody>

                    <%if (list != null && !list.isEmpty()) {

                        int stt = 1;

                        for (Brand brand : list) {%>

                    <tr>

                        <td class="text-center">
                            <%= stt++ %>
                        </td>

                        <td>

                            <strong>
                                <%= brand.getBrandName() %>
                            </strong>

                        </td>

                        <td>
                            <%= brand.getCountry() != null
                                    ? brand.getCountry()
                                    : "" %>
                        </td>

                        <td>
                            <%= brand.getDescription() != null
                                    ? brand.getDescription()
                                    : "" %>
                        </td>

                        <td class="text-center">

                            <!-- SỬA -->

                            <button type="button" class="btn btn-outline-light text-dark" data-bs-toggle="modal"
                                    data-bs-target="#editBrandModal<%= brand.getBrandId() %>">

                                Sửa

                            </button>

                            <!-- XÓA -->

                            <form method="post" action="<%= request.getContextPath() %>/brand" style="display: inline;">

                                <input type="hidden" name="action" value="delete">

                                <input type="hidden" name="brandId" value="<%= brand.getBrandId() %>">

                                <button type="submit" class="btn btn-outline-light text-dark"
                                        onclick="return confirm('Bạn có chắc muốn xóa thương hiệu này không?');">

                                    Xóa

                                </button>

                            </form>

                        </td>

                    </tr>

                    <!-- EDIT MODAL -->

                    <div class="modal fade" id="editBrandModal<%= brand.getBrandId() %>" tabindex="-1">

                        <div class="modal-dialog">

                            <div class="modal-content">

                                <div class="modal-header">

                                    <h5 class="modal-title">
                                        Sửa thương hiệu </h5>

                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>

                                </div>

                                <form method="post" action="<%= request.getContextPath() %>/brand">

                                    <div class="modal-body">

                                        <input type="hidden" name="action" value="update">

                                        <input type="hidden" name="brandId" value="<%= brand.getBrandId() %>">

                                        <div class="mb-3">

                                            <label class="form-label"> Tên thương hiệu </label>

                                            <input type="text" name="brandName" class="form-control"
                                                   value="<%= brand.getBrandName() %>" required>

                                        </div>

                                        <div class="mb-3">

                                            <label class="form-label"> Quốc gia </label>

                                            <input type="text" name="country" class="form-control" value="<%= brand.getCountry() != null
                                                           ? brand.getCountry()
                                                           : "" %>">

                                        </div>

                                        <div class="mb-3">

                                            <label class="form-label"> Mô tả </label>

                                            <textarea name="description" class="form-control"
                                                      rows="3"><%= brand.getDescription() != null
                                                    ? brand.getDescription()
                                                    : "" %></textarea>

                                        </div>

                                    </div>

                                    <div class="modal-footer">

                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">

                                            Hủy

                                        </button>

                                        <button type="submit" class="btn btn-primary">

                                            Lưu thay đổi

                                        </button>

                                    </div>

                                </form>

                            </div>

                        </div>

                    </div>

                    <%}

                    } else {%>

                    <tr>

                        <td colspan="5" class="text-center
                                   text-muted
                                   py-4">

                            Chưa có thương hiệu nào.

                        </td>

                    </tr>

                    <%}%>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<!-- ADD BRAND MODAL -->

<div class="modal fade" id="addBrandModal" tabindex="-1">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title">
                    Thêm thương hiệu </h5>

                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>

            </div>

            <form method="post" action="<%= request.getContextPath() %>/brand">

                <div class="modal-body">

                    <input type="hidden" name="action" value="create">

                    <div class="mb-3">

                        <label class="form-label"> Tên thương hiệu </label>

                        <input type="text" name="brandName" class="form-control" placeholder="Nhập tên thương hiệu"
                               required>

                    </div>

                    <div class="mb-3">

                        <label class="form-label"> Quốc gia </label>

                        <input type="text" name="country" class="form-control" placeholder="Nhập quốc gia">

                    </div>

                    <div class="mb-3">

                        <label class="form-label"> Mô tả </label>

                        <textarea name="description" class="form-control" rows="3" placeholder="Nhập mô tả"></textarea>

                    </div>

                </div>

                <div class="modal-footer">

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">

                        Hủy

                    </button>

                    <button type="submit" class="btn btn-primary">

                        Thêm thương hiệu

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>