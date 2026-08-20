<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.qkl.entity.Product" %>
<%@ page import="com.qkl.entity.Brand" %>
<%@ page import="com.qkl.entity.Category" %>
<%@ page import="com.qkl.entity.User" %>

<%User currentUser = (User) session.getAttribute("user");

    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    List<Product> list =
            (List<Product>) request.getAttribute("list");

    List<Brand> brands =
            (List<Brand>) request.getAttribute("brands");

    List<Category> categories =
            (List<Category>) request.getAttribute("categories");%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Quản lý sản phẩm - Quản Lý Kho</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<!-- NAVBAR -->
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

<!-- CONTENT -->
<div class="container-fluid mt-4">

    <!-- HEADER -->
    <div class="d-flex justify-content-between
                align-items-center mb-3">

        <div>

            <h3 class="mb-1">
                Product </h3>

        </div>

        <div>

            <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-secondary me-2">

                Quản lý hệ thống

            </a>

            <% if ("Manager".equals(currentUser.getRole())) { %>
            <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#addProductModal">

                Thêm sản phẩm

            </button>
            <div class="dropdown d-inline-block me-2">

                <button class="btn btn-outline-dark dropdown-toggle" type="button" data-bs-toggle="dropdown">

                    Sắp xếp

                </button>

                <ul class="dropdown-menu">

                    <li>
                        <h6 class="dropdown-header">
                            Giá nhập </h6>
                    </li>

                    <li>
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/product?sort=importAsc">

                            Giá nhập: Thấp → Cao

                        </a>
                    </li>

                    <li>
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/product?sort=importDesc">

                            Giá nhập: Cao → Thấp

                        </a>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <h6 class="dropdown-header">
                            Giá bán </h6>
                    </li>

                    <li>
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/product?sort=sellingAsc">

                            Giá bán: Thấp → Cao

                        </a>
                    </li>

                    <li>
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/product?sort=sellingDesc">

                            Giá bán: Cao → Thấp

                        </a>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <h6 class="dropdown-header">
                            Tồn kho </h6>
                    </li>

                    <li>
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/product?sort=inventoryAsc">

                            Tồn kho: Thấp → Cao

                        </a>
                    </li>

                    <li>
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/product?sort=inventoryDesc">

                            Tồn kho: Cao → Thấp

                        </a>
                    </li>

                </ul>

            </div>
            <% } %>
        </div>

    </div>
    <%String message = (String) request.getAttribute("message");

        if (message != null) {%>

    <div class="alert alert-warning alert-dismissible fade show" role="alert">

        <%= message %>

        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>

    </div>

    <%}%>

    <!-- TABLE CARD -->
    <div class="card shadow-sm">

        <div class="card-header bg-white">

            <strong> Danh sách sản phẩm </strong>

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
                            Tên sản phẩm
                        </th>

                        <th>
                            Thương hiệu
                        </th>

                        <th>
                            Danh mục
                        </th>

                        <th>
                            Đơn vị
                        </th>

                        <th>
                            Giá nhập
                        </th>

                        <th>
                            Giá bán
                        </th>

                        <th>
                            Tồn kho
                        </th>

                        <th class="text-center">
                            Thao tác
                        </th>

                    </tr>

                    </thead>

                    <tbody>

                    <%if (list != null && !list.isEmpty()) {

                        int stt = 1;

                        for (Product product : list) {%>

                    <tr>

                        <td class="text-center">
                            <%= stt++ %>
                        </td>

                        <td>

                            <strong>
                                <%= product.getProductName() %>
                            </strong>

                        </td>

                        <td>
                            <%= product.getBrand() != null
                                    ? product.getBrand().getBrandName()
                                    : "" %>
                        </td>

                        <td>
                            <%= product.getCategory() != null
                                    ? product.getCategory().getCategoryName()
                                    : "" %>
                        </td>

                        <td>
                            <%= product.getUnit() != null
                                    ? product.getUnit()
                                    : "" %>
                        </td>

                        <td>
                            <%= String.format("%,.0f",
                                    product.getImportPrice()) %>
                        </td>

                        <td>
                            <%= String.format("%,.0f",
                                    product.getSellingPrice()) %>
                        </td>

                        <td>

                            <%if (product.getInventory() != null) {%>

                            <%= product.getInventory().getQuantity() %>

                            <%} else {%>

                            0

                            <%}%>

                        </td>

                        <td class="text-center">

                            <% if ("Manager".equals(currentUser.getRole())) { %>

                            <!-- SỬA -->

                            <button type="button" class="btn btn-outline-light text-dark" data-bs-toggle="modal"
                                    data-bs-target="#editProductModal<%= product.getProductId() %>">

                                Sửa

                            </button>

                            <!-- XÓA -->

                            <form method="post" action="<%= request.getContextPath() %>/product"
                                  style="display:inline;">

                                <input type="hidden" name="action" value="delete">

                                <input type="hidden" name="productId" value="<%= product.getProductId() %>">

                                <button type="submit" class="btn btn-outline-light text-dark"
                                        onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này không?');">

                                    Xóa

                                </button>

                            </form>

                            <% } else { %>

                            <span class="text-muted">
            Chỉ xem
        </span>

                            <% } %>

                        </td>

                    </tr>

                    <!-- EDIT MODAL --><% if ("Manager".equals(currentUser.getRole())) { %>
                    <div class="modal fade" id="editProductModal<%= product.getProductId() %>" tabindex="-1">

                        <div class="modal-dialog modal-lg">

                            <div class="modal-content">

                                <div class="modal-header">

                                    <h5 class="modal-title">
                                        Sửa sản phẩm </h5>

                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>

                                </div>

                                <form method="post" action="<%= request.getContextPath() %>/product">

                                    <div class="modal-body">

                                        <input type="hidden" name="action" value="update">

                                        <input type="hidden" name="productId" value="<%= product.getProductId() %>">

                                        <div class="mb-3">

                                            <label class="form-label"> Tên sản phẩm </label>

                                            <input type="text" name="productName" class="form-control"
                                                   value="<%= product.getProductName() %>" required>

                                        </div>

                                        <div class="row">

                                            <div class="col-md-6 mb-3">

                                                <label class="form-label"> Thương hiệu </label>

                                                <select name="brandId" class="form-select" required>

                                                    <%for (Brand brand : brands) {%>

                                                    <option value="<%= brand.getBrandId() %>"<%= product.getBrand() != null &&
                                                            product.getBrand().getBrandId()
                                                                    .equals(brand.getBrandId())
                                                            ? "selected"
                                                            : "" %>>

                                                        <%= brand.getBrandName() %>

                                                    </option>

                                                    <%}%>

                                                </select>

                                            </div>

                                            <div class="col-md-6 mb-3">

                                                <label class="form-label"> Danh mục </label>

                                                <select name="categoryId" class="form-select" required>

                                                    <%for (Category category : categories) {%>

                                                    <option value="<%= category.getCategoryId() %>"<%= product.getCategory() != null &&
                                                            product.getCategory().getCategoryId()
                                                                    .equals(category.getCategoryId())
                                                            ? "selected"
                                                            : "" %>>

                                                        <%= category.getCategoryName() %>

                                                    </option>

                                                    <%}%>

                                                </select>

                                            </div>

                                        </div>

                                        <div class="row">

                                            <div class="col-md-4 mb-3">

                                                <label class="form-label"> Đơn vị </label>

                                                <input type="text" name="unit" class="form-control" value="<%= product.getUnit() != null
                                                               ? product.getUnit()
                                                               : "" %>" required>

                                            </div>

                                            <div class="col-md-4 mb-3">

                                                <label class="form-label"> Giá nhập </label>

                                                <input type="number" name="importPrice" class="form-control"
                                                       value="<%= String.format("%.0f", product.getImportPrice()) %>"
                                                       min="0" step="100000" required
                                                       oninvalid="this.setCustomValidity('Giá nhập phải lớn hơn hoặc bằng 0!')"
                                                       oninput="this.setCustomValidity('')">

                                            </div>

                                            <div class="col-md-4 mb-3">

                                                <label class="form-label"> Giá bán </label>

                                                <input type="number" name="sellingPrice" class="form-control"
                                                       value="<%= String.format("%.0f", product.getSellingPrice()) %>"
                                                       min="0" step="100000" required
                                                       oninvalid="this.setCustomValidity('Giá bán phải lớn hơn hoặc bằng 0!')"
                                                       oninput="this.setCustomValidity('')">

                                            </div>

                                        </div>

                                        <div class="mb-3">

                                            <label class="form-label"> Mô tả </label>

                                            <textarea name="description" class="form-control"
                                                      rows="3"><%= product.getDescription() != null
                                                    ? product.getDescription()
                                                    : "" %></textarea>

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
                    <% } %>

                    <%}

                    } else {%>

                    <tr>

                        <td colspan="9" class="text-center
                                   text-muted
                                   py-4">

                            Chưa có sản phẩm nào.

                        </td>

                    </tr>

                    <%}%>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<!-- ADD PRODUCT MODAL --><% if ("Manager".equals(currentUser.getRole())) { %>
<div class="modal fade" id="addProductModal" tabindex="-1">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title">
                    Thêm sản phẩm </h5>

                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>

            </div>

            <form method="post" action="<%= request.getContextPath() %>/product">

                <div class="modal-body">

                    <input type="hidden" name="action" value="create">

                    <div class="mb-3">

                        <label class="form-label"> Tên sản phẩm </label>

                        <input type="text" name="productName" class="form-control" placeholder="Nhập tên sản phẩm"
                               required>

                    </div>

                    <div class="row">

                        <div class="col-md-6 mb-3">

                            <label class="form-label"> Thương hiệu </label>

                            <select name="brandId" class="form-select" required>

                                <option value="">
                                    -- Chọn thương hiệu --
                                </option>

                                <%for (Brand brand : brands) {%>

                                <option value="<%= brand.getBrandId() %>">

                                    <%= brand.getBrandName() %>

                                </option>

                                <%}%>

                            </select>

                        </div>

                        <div class="col-md-6 mb-3">

                            <label class="form-label"> Danh mục </label>

                            <select name="categoryId" class="form-select" required>

                                <option value="">
                                    -- Chọn danh mục --
                                </option>

                                <%for (Category category : categories) {%>

                                <option value="<%= category.getCategoryId() %>">

                                    <%= category.getCategoryName() %>

                                </option>

                                <%}%>

                            </select>

                        </div>

                    </div>

                    <div class="row">

                        <div class="col-md-4 mb-3">

                            <label class="form-label"> Đơn vị </label>

                            <input type="text" name="unit" class="form-control" placeholder="Ví dụ: Cái" required>

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label"> Giá nhập </label>

                            <input type="number" name="importPrice" class="form-control" min="0" step="100000" required
                                   oninvalid="this.setCustomValidity('Giá nhập phải lớn hơn hoặc bằng 0!')"
                                   oninput="this.setCustomValidity('')">

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label"> Giá bán </label>

                            <input type="number" name="sellingPrice" class="form-control" min="0" step="100000" required
                                   oninvalid="this.setCustomValidity('Giá bán phải lớn hơn hoặc bằng 0!')"
                                   oninput="this.setCustomValidity('')">

                        </div>

                    </div>

                    <div class="mb-3">

                        <label class="form-label"> Mô tả </label>

                        <textarea name="description" class="form-control" rows="3" placeholder="Nhập mô tả"></textarea>

                    </div>

                </div>

                <div class="modal-footer">

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">

                        Hủy

                    </button>

                    <button type="submit" class="btn btn-primary">

                        Thêm sản phẩm

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>