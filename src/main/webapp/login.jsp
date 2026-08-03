<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Đăng nhập</h2>
<form action="login" method="post">
    Username
    <input type="text" name="username">
    <br><br>
    Password
    <input type="password" name="password">
    <br><br>
    <button>Đăng nhập</button>
</form>
<p style="color:red">
        <%
    String message = (String) request.getAttribute("message");
    if (message != null) {
%>
<p style="color:red"><%= message %></p>
<%
    }
%>
</p>
</body>
</html>