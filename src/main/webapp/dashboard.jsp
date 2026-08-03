<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <span class="navbar-brand">
            Quản Lí Kho Nhập Hàng
        </span>

        <div class="text-white">

            Xin chào,
            <b>${sessionScope.user.fullName}</b>
            |
            <a href="logout"
               class="text-warning text-decoration-none">
                Đăng xuất
            </a>

        </div>

    </div>

</nav>

<div class="container-fluid">

    <div class="row">

        <div class="col-2 bg-light vh-100 p-3">

            <h5>MENU</h5>

            <div class="list-group">
                <a href="dashboard"
                   class="list-group-item">
                    Dashboard
                </a>
                <a href="category"
                   class="list-group-item">
                    Category
                </a>
                <a href="brand"
                   class="list-group-item">
                    Brand
                </a>
                <a href="product"
                   class="list-group-item">
                    Product
                </a>
                <a href="supplier"
                   class="list-group-item">
                    Supplier
                </a>
                <a href="inventory"
                   class="list-group-item">
                    Inventory
                </a>
                <a href="receipt"
                   class="list-group-item">
                    Import Receipt
                </a>
                <a href="user"
                   class="list-group-item">
                    User
                </a>
            </div>
        </div>

        <div class="col-10 p-4">
            <h2>Dashboard</h2>
            <hr>
            <div class="alert alert-success">
                Chào mừng bạn đến với hệ thống quản lý kho.
            </div>
        </div>

    </div>

</div>

</body>
</html>