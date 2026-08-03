<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
</head>
<body>
<h2>Đăng nhập thành công!</h2>
<h3>Xin chào ${sessionScope.user.fullName}</h3>
<a href="logout">Đăng xuất</a>
</body>
</html>