<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.qkl.entity.Category"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
<h2>Category Management</h2>
<hr>
<form action="category" method="post">
    <input type="hidden"
           name="categoryId"
           id="categoryId">
    <div class="mb-3">
        <label>Tên loại</label>
        <input class="form-control"
               type="text"
               name="categoryName"
               id="categoryName"
               required>
    </div>
    <button class="btn btn-primary me-2"
            name="action"
            value="create">
        Thêm
    </button>

    <button class="btn btn-primary me-2"
            name="action"
            value="update">
        Sửa
    </button>

    <button class="btn btn-primary"
            name="action"
            value="delete"
            onclick="return confirm('Bạn có chắc muốn xóa?')">
        Xóa
    </button>
</form>
<hr>
<table class="table table-bordered">
    <tr>
        <th>ID</th>
        <th>Tên loại</th>
        <th>Chọn</th>
    </tr>
    <%
        List<Category> list = (List<Category>)request.getAttribute("list");
        for(Category c:list){
    %>

    <tr>
        <td><%=c.getCategoryId()%></td>
        <td><%=c.getCategoryName()%></td>
        <td>
            <button
                    class="btn btn-primary btn-sm"
                    onclick="
                            document.getElementById('categoryId').value='<%=c.getCategoryId()%>';
                            document.getElementById('categoryName').value='<%=c.getCategoryName()%>';
                            ">
                Chọn
            </button>
        </td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>