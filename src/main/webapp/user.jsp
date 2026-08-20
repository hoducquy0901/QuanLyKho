<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.qkl.entity.User" %>

<%User currentUser =
        (User) session.getAttribute("user");


    // ==============================
    // KIỂM TRA ĐĂNG NHẬP
    // ==============================

    if (currentUser == null) {

        response.sendRedirect(
                request.getContextPath()
                        + "/login"
        );

        return;
    }


    // ==============================
    // CHỈ MANAGER ĐƯỢC XEM
    // ==============================

    if (!"Manager".equals(currentUser.getRole())) {

        response.sendRedirect(
                request.getContextPath()
                        + "/dashboard"
        );

        return;
    }


    List<User> list =
            (List<User>) request.getAttribute("list");%>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Quản lý nhân viên - Quản Lý Kho</title>

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
                Quản lý nhân viên </h3>

            <p class="text-muted mb-0">
                Quản lý tài khoản người dùng </p>

        </div>

        <!-- THÊM -->
        <div>
            <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-secondary me-2">

                Quản lý hệ thống

            </a>

            <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#addUserModal">

                Thêm nhân viên

            </button>
        </div>
    </div>

    <!-- ================= TABLE ================= -->

    <div class="card shadow-sm">

        <div class="card-header bg-white">

            <strong> Danh sách người dùng </strong>

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
                            ID
                        </th>

                        <th>
                            Họ tên
                        </th>

                        <th>
                            Username
                        </th>

                        <th>
                            Email
                        </th>

                        <th>
                            Số điện thoại
                        </th>

                        <th>
                            Vai trò
                        </th>

                        <th class="text-center">
                            Thao tác
                        </th>

                    </tr>

                    </thead>

                    <tbody>

                    <%if (list != null &&
                            !list.isEmpty()) {

                        int stt = 1;

                        for (User user : list) {%>

                    <tr>

                        <!-- STT -->

                        <td class="text-center">
                            <%= stt++ %>
                        </td>

                        <!-- ID -->

                        <td>
                            <%= user.getUsersId() %>
                        </td>

                        <!-- HỌ TÊN -->

                        <td>

                            <strong>
                                <%= user.getFullName() %>
                            </strong>

                        </td>

                        <!-- USERNAME -->

                        <td>
                            <%= user.getUsername() %>
                        </td>

                        <!-- EMAIL -->

                        <td>
                            <%= user.getEmail() %>
                        </td>

                        <!-- PHONE -->

                        <td>
                            <%= user.getPhone() %>
                        </td>

                        <!-- ROLE -->

                        <td>

                            <%if ("Manager".equals(user.getRole())) {%>

                            <span class="badge bg-danger">
                                Manager
                            </span>

                            <%} else {%>

                            <span class="badge bg-secondary">
                                Employee
                            </span>

                            <%}%>

                        </td>

                        <!-- THAO TÁC -->

                        <td class="text-center">

                            <!-- SỬA -->

                            <button type="button" class="btn btn-outline-dark btn-sm" data-bs-toggle="modal"
                                    data-bs-target="#editUserModal<%= user.getUsersId() %>">

                                Sửa

                            </button>

                            <!-- XÓA -->

                            <%if (currentUser.getUsersId() != null
                                    && !currentUser.getUsersId()
                                    .equals(user.getUsersId())) {%>

                            <form method="post" action="<%= request.getContextPath() %>/user" style="display:inline;">

                                <input type="hidden" name="action" value="delete">

                                <input type="hidden" name="usersId" value="<%= user.getUsersId() %>">

                                <button type="submit" class="btn btn-outline-danger btn-sm"
                                        onclick="return confirm('Bạn có chắc muốn xóa tài khoản này không?');">

                                    Xóa

                                </button>

                            </form>

                            <%}%>

                        </td>

                    </tr>

                    <!-- ================= EDIT MODAL ================= -->

                    <div class="modal fade" id="editUserModal<%= user.getUsersId() %>" tabindex="-1">

                        <div class="modal-dialog">

                            <div class="modal-content">

                                <div class="modal-header">

                                    <h5 class="modal-title">

                                        Sửa nhân viên

                                    </h5>

                                    <button type="button" class="btn-close" data-bs-dismiss="modal">

                                    </button>

                                </div>

                                <form method="post" action="<%= request.getContextPath() %>/user">

                                    <div class="modal-body">

                                        <input type="hidden" name="action" value="update">

                                        <input type="hidden" name="usersId" value="<%= user.getUsersId() %>">

                                        <!-- HỌ TÊN -->

                                        <div class="mb-3">

                                            <label class="form-label"> Họ tên </label>

                                            <input type="text" name="fullName" class="form-control"
                                                   value="<%= user.getFullName() %>" required>

                                        </div>

                                        <!-- USERNAME -->

                                        <div class="mb-3">

                                            <label class="form-label"> Username </label>

                                            <input type="text" name="username" class="form-control"
                                                   value="<%= user.getUsername() %>" required>

                                        </div>

                                        <!-- EMAIL -->

                                        <div class="mb-3">

                                            <label class="form-label"> Email </label>

                                            <input type="email" name="email" class="form-control"
                                                   value="<%= user.getEmail() %>" required>

                                        </div>

                                        <!-- PHONE -->

                                        <div class="mb-3">

                                            <label class="form-label"> Số điện thoại </label>

                                            <input type="text" name="phone" class="form-control"
                                                   value="<%= user.getPhone() %>" required>

                                        </div>

                                        <!-- ROLE -->

                                        <div class="mb-3">

                                            <label class="form-label"> Vai trò </label>

                                            <select name="role" class="form-select" required>

                                                <option value="Employee"<%= "Employee".equals(user.getRole())
                                                        ? "selected"
                                                        : "" %>>

                                                    Employee

                                                </option>

                                                <option value="Manager"<%= "Manager".equals(user.getRole())
                                                        ? "selected"
                                                        : "" %>>

                                                    Manager

                                                </option>

                                            </select>

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

                        <td colspan="8" class="text-center
                                   text-muted
                                   py-4">

                            Chưa có tài khoản nào.

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

<div class="modal fade" id="addUserModal" tabindex="-1">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title">

                    Thêm nhân viên

                </h5>

                <button type="button" class="btn-close" data-bs-dismiss="modal">

                </button>

            </div>

            <form method="post" action="<%= request.getContextPath() %>/user">

                <div class="modal-body">

                    <input type="hidden" name="action" value="create">

                    <!-- HỌ TÊN -->

                    <div class="mb-3">

                        <label class="form-label"> Họ tên </label>

                        <input type="text" name="fullName" class="form-control" placeholder="Nhập họ tên" required>

                    </div>

                    <!-- USERNAME -->

                    <div class="mb-3">

                        <label class="form-label"> Username </label>

                        <input type="text" name="username" class="form-control" placeholder="Nhập username" required>

                    </div>

                    <!-- EMAIL -->

                    <div class="mb-3">

                        <label class="form-label"> Email </label>

                        <input type="email" name="email" class="form-control" placeholder="Nhập email" required>

                    </div>

                    <!-- PHONE -->

                    <div class="mb-3">

                        <label class="form-label"> Số điện thoại </label>

                        <input type="text" name="phone" class="form-control" placeholder="Nhập số điện thoại" required>

                    </div>

                    <!-- PASSWORD -->

                    <div class="mb-3">

                        <label class="form-label"> Mật khẩu </label>

                        <input type="text" name="password" class="form-control" placeholder="Nhập mật khẩu" required>

                    </div>

                    <!-- ROLE -->

                    <div class="mb-3">

                        <label class="form-label"> Vai trò </label>

                        <select name="role" class="form-select" required>

                            <option value="Employee">
                                Employee
                            </option>

                            <option value="Manager">
                                Manager
                            </option>

                        </select>

                    </div>

                </div>

                <div class="modal-footer">

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">

                        Hủy

                    </button>

                    <button type="submit" class="btn btn-primary">

                        Thêm nhân viên

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