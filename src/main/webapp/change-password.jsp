<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.qkl.entity.User" %>

<%User currentUser =
        (User) session.getAttribute("user");

    if (currentUser == null) {
        response.sendRedirect(
                request.getContextPath() + "/login"
        );
        return;
    }

    String message =
            (String) request.getAttribute("message");

    String success =
            (String) request.getAttribute("success");%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Đổi mật khẩu - Quản Lý Kho</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<!-- NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/home">

            Quản Lý Kho

        </a>

        <div class="d-flex align-items-center">

            <span class="text-white me-3">

                <strong>
                    <%= currentUser.getFullName() %>
                </strong>

                <span class="badge bg-secondary ms-2">
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

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-6">

            <div class="card shadow-sm">

                <div class="card-header">

                    <h4 class="mb-0">
                        Đổi mật khẩu </h4>

                </div>

                <div class="card-body">

                    <% if (message != null) { %>

                    <div class="alert alert-danger">
                        <%= message %>
                    </div>

                    <% } %>

                    <% if (success != null) { %>

                    <div class="alert alert-success">
                        <%= success %>
                    </div>

                    <% } %>

                    <form method="post" action="<%= request.getContextPath() %>/change-password">

                        <!-- MẬT KHẨU CŨ -->

                        <div class="mb-3">

                            <label class="form-label"> Mật khẩu hiện tại </label>

                            <input type="password" name="currentPassword" class="form-control" required>

                        </div>

                        <!-- MẬT KHẨU MỚI -->

                        <div class="mb-3">

                            <label class="form-label"> Mật khẩu mới </label>

                            <input type="password" name="newPassword" class="form-control" minlength="4" required>

                        </div>

                        <!-- XÁC NHẬN -->

                        <div class="mb-3">

                            <label class="form-label"> Nhập lại mật khẩu mới </label>

                            <input type="password" name="confirmPassword" class="form-control" minlength="4" required>

                        </div>

                        <div class="d-flex justify-content-between">

                            <a href="<%= request.getContextPath() %>/home" class="btn btn-secondary">

                                Hủy

                            </a>

                            <button type="submit" class="btn btn-primary">

                                Đổi mật khẩu

                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>