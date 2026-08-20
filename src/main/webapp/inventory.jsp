<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.qkl.entity.Inventory" %>
<%@ page import="com.qkl.entity.User" %>

<%User currentUser = (User) session.getAttribute("user");

    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    List<Inventory> list =
            (List<Inventory>) request.getAttribute("list");
    SimpleDateFormat dateFormat =
            new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Quản lý tồn kho - Quản Lý Kho</title>

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

                Inventory

            </h3>

        </div>

        <div>

            <div>
                <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-secondary">

                    Quản lý hệ thống

                </a>

                <div class="dropdown d-inline-block me-2">

                    <button class="btn btn-outline-dark dropdown-toggle" type="button" data-bs-toggle="dropdown">

                        Sắp xếp

                    </button>

                    <ul class="dropdown-menu">

                        <li>
                            <h6 class="dropdown-header">
                                Số lượng tồn </h6>
                        </li>

                        <li>
                            <a class="dropdown-item" href="<%= request.getContextPath() %>/inventory?sort=quantityAsc">

                                Thấp → Cao

                            </a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="<%= request.getContextPath() %>/inventory?sort=quantityDesc">

                                Cao → Thấp

                            </a>
                        </li>

                        <li>
                            <hr class="dropdown-divider">
                        </li>

                        <li>
                            <h6 class="dropdown-header">
                                Cập nhật lần cuối </h6>
                        </li>

                        <li>
                            <a class="dropdown-item" href="<%= request.getContextPath() %>/inventory?sort=updatedDesc">

                                Mới nhất → Cũ nhất

                            </a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="<%= request.getContextPath() %>/inventory?sort=updatedAsc">

                                Cũ nhất → Mới nhất

                            </a>
                        </li>

                    </ul>

                </div>

            </div>

        </div>

    </div>

    <!-- TABLE CARD -->

    <div class="card shadow-sm">

        <div class="card-header bg-white">

            <strong>

                Danh sách tồn kho

            </strong>

        </div>

        <div class="card-body p-0">

            <div class="table-responsive">

                <table class="table table-hover
                              table-bordered
                              mb-0">

                    <thead class="table-dark">

                    <tr>

                        <th class="text-center" style="width: 100px;">

                            STT

                        </th>

                        <th>

                            Sản phẩm

                        </th>

                        <th class="text-center">

                            Số lượng tồn

                        </th>

                        <th>

                            Cập nhật lần cuối

                        </th>

                        <th class="text-center" style="width: 220px;">

                            Thao tác

                        </th>

                    </tr>

                    </thead>

                    <tbody>

                    <%if (list != null && !list.isEmpty()) {

                        int stt = 1;

                        for (Inventory inventory : list) {%>

                    <tr>

                        <!-- STT -->

                        <td class="text-center">

                            <%= stt++ %>

                        </td>

                        <!-- PRODUCT -->

                        <td>

                            <strong>

                                <%= inventory.getProduct() != null
                                        ? inventory.getProduct().getProductName()
                                        : "" %>

                            </strong>

                        </td>

                        <!-- QUANTITY -->

                        <td class="text-center">

                            <strong>

                                <%= inventory.getQuantity() != null
                                        ? inventory.getQuantity()
                                        : 0 %>

                            </strong>

                        </td>

                        <!-- LAST UPDATED -->

                        <td>

                            <%= inventory.getLastUpdated() != null
                                    ? dateFormat.format(inventory.getLastUpdated())
                                    : "" %>

                        </td>

                        <!-- ACTION -->

                        <td class="text-center">

                            <% if ("Manager".equals(currentUser.getRole())) { %>

                            <!-- SỬA -->

                            <button type="button" class="btn btn-outline-light text-dark" data-bs-toggle="modal"
                                    data-bs-target="#editInventoryModal<%= inventory.getInventoryId() %>">

                                Sửa

                            </button>

                            <!-- XÓA -->


                            <% } else { %>

                            <span class="text-muted">

                                Chỉ xem

                            </span>

                            <% } %>

                        </td>

                    </tr>

                    <!-- EDIT MODAL -->

                    <% if ("Manager".equals(currentUser.getRole())) { %>

                    <div class="modal fade" id="editInventoryModal<%= inventory.getInventoryId() %>" tabindex="-1">

                        <div class="modal-dialog">

                            <div class="modal-content">

                                <div class="modal-header">

                                    <h5 class="modal-title">

                                        Sửa tồn kho

                                    </h5>

                                    <button type="button" class="btn-close" data-bs-dismiss="modal">

                                    </button>

                                </div>

                                <form method="post" action="<%= request.getContextPath() %>/inventory">

                                    <div class="modal-body">

                                        <input type="hidden" name="action" value="update">

                                        <input type="hidden" name="inventoryId"
                                               value="<%= inventory.getInventoryId() %>">

                                        <!-- PRODUCT -->

                                        <div class="mb-3">

                                            <label class="form-label">

                                                Sản phẩm

                                            </label>

                                            <input type="text" class="form-control" value="<%= inventory.getProduct() != null
                                                           ? inventory.getProduct().getProductName()
                                                           : "" %>" readonly>

                                        </div>

                                        <!-- QUANTITY -->

                                        <div class="mb-3">

                                            <label class="form-label">

                                                Số lượng tồn

                                            </label>

                                            <input type="number" name="quantity" class="form-control" value="<%= inventory.getQuantity() != null
                                                           ? inventory.getQuantity()
                                                           : 0 %>" min="0" required>

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

                        <td colspan="5" class="text-center
                                   text-muted
                                   py-4">

                            Chưa có dữ liệu tồn kho.

                        </td>

                    </tr>

                    <%}%>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>