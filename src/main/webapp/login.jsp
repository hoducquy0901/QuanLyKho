<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Quản lý kho</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
        }
        body {
            background: url('${pageContext.request.contextPath}/assets/img/login-bg.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .login-overlay {
            min-height: 100vh;
            background: rgba(0, 0, 0, 0.55);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            width: 100%;
            max-width: 380px;
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
        }
        .login-card .card-body {
            padding: 2.5rem 2rem;
        }
        .login-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: #0d6efd;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem auto;
        }
        .login-icon svg {
            width: 28px;
            height: 28px;
            fill: #fff;
        }
    </style>
</head>
<body>

<div class="login-overlay">
    <div class="card login-card">
        <div class="card-body">
            <div class="login-icon">
                <svg viewBox="0 0 24 24"><path d="M12 2a5 5 0 0 0-5 5v3H6a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8a2 2 0 0 0-2-2h-1V7a5 5 0 0 0-5-5zm-3 8V7a3 3 0 0 1 6 0v3H9z"/></svg>
            </div>
            <h4 class="text-center mb-1">WMS</h4>

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger py-2" role="alert">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Please enter LoginId" required autofocus>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.js"></script>
</body>
</html>
