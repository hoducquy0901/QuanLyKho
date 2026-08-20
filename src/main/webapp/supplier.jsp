<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.qkl.entity.Supplier" %>
<%@ page import="com.qkl.entity.User" %>

<%User currentUser =
        (User) session.getAttribute("user");

    if (currentUser == null) {

        response.sendRedirect(
                request.getContextPath() + "/login"
        );

        return;
    }

    // Supplier chỉ dành cho Manager
    if (!"Manager".equals(currentUser.getRole())) {

        response.sendRedirect(
                request.getContextPath() + "/dashboard"
        );

        return;
    }

    List<Supplier> list =
            (List<Supplier>) request.getAttribute("list");%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Quản lý nhà cung cấp - Quản Lý Kho</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<!-- ================= NAVBAR ================= -->

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

<!-- ================= CONTENT ================= -->

<div class="container-fluid mt-4">

    <!-- HEADER -->

    <div class="d-flex justify-content-between
                align-items-center mb-3">

        <div>

            <h3 class="mb-1">
                Supplier </h3>

        </div>

        <div>

            <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-secondary me-2">

                Quản lý hệ thống

            </a>

            <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#addSupplierModal">

                Thêm nhà cung cấp

            </button>

        </div>

    </div>

    <!-- ================= TABLE ================= -->

    <div class="card shadow-sm">

        <div class="card-header bg-white">

            <strong> Danh sách nhà cung cấp </strong>

        </div>

        <div class="card-body p-0">

            <div class="table-responsive">

                <table class="table table-hover
                              table-bordered
                              mb-0">

                    <thead class="table-dark">

                    <tr>

                        <th class="text-center">
                            STT
                        </th>

                        <th>
                            Mã NCC
                        </th>

                        <th>
                            Tên nhà cung cấp
                        </th>

                        <th>
                            Địa chỉ
                        </th>

                        <th>
                            Số điện thoại
                        </th>

                        <th>
                            Email
                        </th>

                        <th class="text-center">
                            Thao tác
                        </th>

                    </tr>

                    </thead>

                    <tbody>

                    <%if (list != null && !list.isEmpty()) {

                        int stt = 1;

                        for (Supplier supplier : list) {%>

                    <tr>

                        <!-- STT -->

                        <td class="text-center">

                            <%= stt++ %>

                        </td>

                        <!-- MÃ NCC -->

                        <td>

                            <strong> #<%= supplier.getSupplierId() %>
                            </strong>

                        </td>

                        <!-- TÊN -->

                        <td>

                            <strong>
                                <%= supplier.getSupplierName() %>
                            </strong>

                        </td>

                        <!-- ĐỊA CHỈ -->

                        <td>

                            <%= supplier.getAddress() != null
                                    ? supplier.getAddress()
                                    : "" %>

                        </td>

                        <!-- PHONE -->

                        <td>

                            <%= supplier.getPhone() != null
                                    ? supplier.getPhone()
                                    : "" %>

                        </td>

                        <!-- EMAIL -->

                        <td>

                            <%= supplier.getEmail() != null
                                    ? supplier.getEmail()
                                    : "" %>

                        </td>

                        <!-- THAO TÁC -->

                        <td class="text-center">

                            <!-- SỬA -->

                            <button type="button" class="btn btn-outline-light text-dark" data-bs-toggle="modal"
                                    data-bs-target="#editSupplierModal<%= supplier.getSupplierId() %>">

                                Sửa

                            </button>

                            <!-- XÓA -->

                            <form method="post" action="<%= request.getContextPath() %>/supplier"
                                  style="display:inline;">

                                <input type="hidden" name="action" value="delete">

                                <input type="hidden" name="supplierId" value="<%= supplier.getSupplierId() %>">

                                <button type="submit" class="btn btn-outline-light text-dark"
                                        onclick="return confirm('Bạn có chắc muốn xóa nhà cung cấp này không?');">

                                    Xóa

                                </button>

                            </form>

                        </td>

                    </tr>

                    <!-- ================= EDIT MODAL ================= -->

                    <div class="modal fade" id="editSupplierModal<%= supplier.getSupplierId() %>" tabindex="-1">

                        <div class="modal-dialog">

                            <div class="modal-content">

                                <div class="modal-header">

                                    <h5 class="modal-title">

                                        Sửa nhà cung cấp

                                    </h5>

                                    <button type="button" class="btn-close" data-bs-dismiss="modal">

                                    </button>

                                </div>

                                <form method="post" action="<%= request.getContextPath() %>/supplier">

                                    <div class="modal-body">

                                        <input type="hidden" name="action" value="update">

                                        <input type="hidden" name="supplierId" value="<%= supplier.getSupplierId() %>">

                                        <!-- TÊN -->

                                        <div class="mb-3">

                                            <label class="form-label">

                                                Tên nhà cung cấp

                                            </label>

                                            <input type="text" name="supplierName" class="form-control" value="<%= supplier.getSupplierName() != null
                                                           ? supplier.getSupplierName()
                                                           : "" %>" required>

                                        </div>

                                        <!-- ĐỊA CHỈ -->

                                        <div class="mb-3">

                                            <label class="form-label">

                                                Địa chỉ

                                            </label>

                                            <input type="text" name="address" class="form-control" value="<%= supplier.getAddress() != null
                                                           ? supplier.getAddress()
                                                           : "" %>" required>

                                        </div>

                                        <!-- PHONE -->

                                        <div class="mb-3">

                                            <label class="form-label">

                                                Số điện thoại

                                            </label>

                                            <input type="text" name="phone" class="form-control" value="<%= supplier.getPhone() != null
                                                           ? supplier.getPhone()
                                                           : "" %>" required>

                                        </div>

                                        <!-- EMAIL -->

                                        <div class="mb-3">

                                            <label class="form-label">

                                                Email

                                            </label>

                                            <input type="email" name="email" class="form-control" value="<%= supplier.getEmail() != null
                                                           ? supplier.getEmail()
                                                           : "" %>" required>

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

                    <!-- KHÔNG CÓ DỮ LIỆU -->

                    <tr>

                        <td colspan="7" class="text-center
                                   text-muted
                                   py-4">

                            Chưa có nhà cung cấp nào.

                        </td>

                    </tr>

                    <%}%>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<!-- ================= ADD MODAL ================= -->

<div class="modal fade" id="addSupplierModal" tabindex="-1">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title">

                    Thêm nhà cung cấp

                </h5>

                <button type="button" class="btn-close" data-bs-dismiss="modal">

                </button>

            </div>

            <form method="post" action="<%= request.getContextPath() %>/supplier">

                <div class="modal-body">

                    <input type="hidden" name="action" value="create">

                    <!-- TÊN -->

                    <div class="mb-3">

                        <label class="form-label">

                            Tên nhà cung cấp

                        </label>

                        <input type="text" name="supplierName" class="form-control" placeholder="Nhập tên nhà cung cấp"
                               required>

                    </div>

                    <!-- ĐỊA CHỈ -->

                    <div class="mb-3">

                        <label class="form-label">

                            Địa chỉ

                        </label>

                        <input type="text" name="address" class="form-control" placeholder="Nhập địa chỉ" required>

                    </div>

                    <!-- PHONE -->

                    <div class="mb-3">

                        <label class="form-label">

                            Số điện thoại

                        </label>

                        <input type="text" name="phone" class="form-control" placeholder="Nhập số điện thoại" required>

                    </div>

                    <!-- EMAIL -->

                    <div class="mb-3">

                        <label class="form-label">

                            Email

                        </label>

                        <input type="email" name="email" class="form-control" placeholder="Nhập email" required>

                    </div>

                </div>

                <div class="modal-footer">

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">

                        Hủy

                    </button>

                    <button type="submit" class="btn btn-primary">

                        Thêm nhà cung cấp

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

<!-- ================= BOOTSTRAP ================= -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>