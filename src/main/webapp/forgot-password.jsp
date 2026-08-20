<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Quên mật khẩu - Quản Lý Kho</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body {
            background: #f4f6f9;
            min-height: 100vh;
        }

        .navbar {
            height: 64px;
        }

        .forgot-container {
            min-height: calc(100vh - 64px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 15px;
        }

        .forgot-card {
            width: 100%;
            max-width: 430px;
            background: white;
            border-radius: 16px;
            padding: 35px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.10);
        }

        .form-control {
            height: 48px;
            border-radius: 9px;
        }

        .btn-reset {
            width: 100%;
            height: 48px;
            border-radius: 9px;
            font-weight: 600;
        }

        .message {
            background: #f8d7da;
            color: #842029;
            border: 1px solid #f5c2c7;
            border-radius: 8px;
            padding: 10px 12px;
            margin-bottom: 20px;
        }

        .success {
            background: #d1e7dd;
            color: #0f5132;
            border: 1px solid #badbcc;
        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid px-4">

        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/login">

            📦 Quản Lý Kho

        </a>

        <a href="<%= request.getContextPath() %>/login" class="btn btn-outline-light btn-sm">

            Đăng nhập

        </a>

    </div>

</nav>

<!-- CONTENT -->

<div class="forgot-container">

    <div class="forgot-card">

        <div class="text-center mb-4">

            <h2 class="fw-bold">
                Quên mật khẩu? </h2>

            <p class="text-muted">
                Nhập email đã đăng ký để nhận mật khẩu mới. </p>

        </div>

        <!-- ERROR -->

        <%String message =
                (String) request.getAttribute("message");

            if (message != null) {%>

        <div class="message">

            <%= message %>

        </div>

        <%}%>

        <!-- SUCCESS -->

        <%String success =
                (String) request.getAttribute("success");

            if (success != null) {%>

        <div class="message success">

            <%= success %>

        </div>

        <%}%>

        <!-- FORM -->

        <form action="<%= request.getContextPath() %>/forgot-password" method="post">

            <div class="mb-4">

                <label class="form-label fw-semibold"> Email </label>

                <input type="email" name="email" class="form-control" placeholder="Nhập email của bạn" required>

            </div>

            <button type="submit" class="btn btn-dark btn-reset">

                Gửi mật khẩu mới

            </button>

        </form>

        <div class="text-center mt-4">

            <a href="<%= request.getContextPath() %>/login" class="text-decoration-none">

                ← Quay lại đăng nhập

            </a>

        </div>

    </div>

</div>

</body>

</html>