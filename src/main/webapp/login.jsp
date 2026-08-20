<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Đăng nhập - Quản Lý Kho</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body {
            background: #f4f6f9;
            min-height: 100vh;
        }

        /* NAVBAR */

        .navbar {
            height: 64px;
        }

        .navbar-brand {
            font-size: 20px;
            letter-spacing: 0.3px;
        }

        /* LOGIN AREA */

        .login-container {
            min-height: calc(100vh - 64px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 15px;
        }

        /* LOGIN CARD */

        .login-card {
            width: 100%;
            max-width: 430px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.10);
            padding: 35px;
        }

        .login-title {
            font-weight: 700;
            margin-bottom: 8px;
        }

        .login-subtitle {
            color: #6c757d;
            margin-bottom: 30px;
        }

        /* INPUT */

        .form-label {
            font-weight: 500;
        }

        .form-control {
            height: 48px;
            border-radius: 9px;
        }

        .form-control:focus {
            border-color: #212529;
            box-shadow: 0 0 0 0.2rem rgba(33, 37, 41, 0.12);
        }

        /* BUTTON */

        .login-btn {
            height: 48px;
            border-radius: 9px;
            font-weight: 600;
            width: 100%;
        }

        /* ERROR */

        .error-message {
            background: #f8d7da;
            color: #842029;
            border: 1px solid #f5c2c7;
            border-radius: 8px;
            padding: 10px 12px;
            margin-bottom: 20px;
        }

        /* FOOTER */

        .login-footer {
            text-align: center;
            color: #6c757d;
            font-size: 14px;
            margin-top: 25px;
        }

    </style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid px-4">

        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/login">

            📦 Quản Lý Kho

        </a>

    </div>

</nav>

<!-- ================= LOGIN ================= -->

<div class="login-container">

    <div class="login-card">

        <!-- TITLE -->

        <div class="text-center">

            <h2 class="login-title">
                Đăng nhập </h2>

        </div>

        <!-- ERROR MESSAGE -->

        <%String message =
                (String) request.getAttribute("message");

            if (message != null) {%>

        <div class="error-message">

            <%= message %>

        </div>

        <%}%>

        <!-- FORM -->

        <form action="<%= request.getContextPath() %>/login" method="post">

            <!-- USERNAME -->

            <div class="mb-3">

                <label class="form-label"> Username </label>

                <input type="text" name="username" class="form-control" placeholder="Nhập username"
                       autocomplete="username" required>

            </div>

            <!-- PASSWORD -->

            <div class="mb-4">

                <label class="form-label"> Password </label>

                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu"
                       autocomplete="current-password" required>

            </div>
            <div class="text-end mb-4">

                <a href="<%= request.getContextPath() %>/forgot-password" class="text-decoration-none">

                    Quên mật khẩu?

                </a>

            </div>

            <!-- BUTTON -->

            <button type="submit" class="btn btn-dark login-btn">

                Đăng nhập

            </button>

        </form>

        <!-- FOOTER -->

        <div class="login-footer">

            Hệ thống quản lý kho hàng điện tử

        </div>

    </div>

</div>

</body>

</html>