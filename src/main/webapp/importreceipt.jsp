<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="com.qkl.entity.ImportReceipt" %>
<%@ page import="com.qkl.entity.ImportReceiptDetail" %>
<%@ page import="com.qkl.entity.Supplier" %>
<%@ page import="com.qkl.entity.Product" %>
<%@ page import="com.qkl.entity.User" %>

<%User currentUser =
        (User) session.getAttribute("user");

    if (currentUser == null) {
        response.sendRedirect(
                request.getContextPath() + "/login"
        );
        return;
    }

    List<ImportReceipt> receipts =
            (List<ImportReceipt>) request.getAttribute("receipts");

    List<ImportReceiptDetail> details =
            (List<ImportReceiptDetail>) request.getAttribute("details");

    List<Supplier> suppliers =
            (List<Supplier>) request.getAttribute("suppliers");

    List<Product> products =
            (List<Product>) request.getAttribute("products");

    SimpleDateFormat dateFormat =
            new SimpleDateFormat("dd/MM/yyyy HH:mm");%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Quản lý phiếu nhập - Quản Lý Kho</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<script>

    function updateImportPrice() {

        const select =
            document.getElementById("productId");

        const selectedOption =
            select.options[select.selectedIndex];

        const price =
            selectedOption.getAttribute("data-price");

        const unitPrice =
            document.getElementById("unitPrice");

        if (price) {

            unitPrice.value = parseFloat(price);

        } else {

            unitPrice.value = "";

        }

        calculateTotal();
    }


    function calculateTotal() {

        const quantity =
            parseFloat(
                document.getElementById("quantity").value
            ) || 0;

        const unitPrice =
            parseFloat(
                document.getElementById("unitPrice").value
            ) || 0;

        const total =
            quantity * unitPrice;

        document.getElementById("totalDisplay").value =
            total.toLocaleString("vi-VN") + " đ";
    }

</script>

<body class="bg-light">

<!-- ================= NAVBAR ================= -->

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

<!-- ================= CONTENT ================= -->

<div class="container-fluid mt-4">

    <!-- HEADER -->

    <div class="d-flex justify-content-between
                align-items-center mb-3">

        <div>

            <h3 class="mb-1">
                Import Receipt </h3>

        </div>

        <div>

            <!-- QUẢN LÝ HỆ THỐNG -->

            <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-secondary me-2">

                Quản lý hệ thống

            </a>

            <!-- THÊM PHIẾU -->

            <% if ("Manager".equals(currentUser.getRole())
                    || "Employee".equals(currentUser.getRole())) { %>

            <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#addReceiptModal">

                Thêm phiếu nhập

            </button>
            <!-- SẮP XẾP -->

            <div class="dropdown d-inline-block me-2">

                <button class="btn btn-outline-dark dropdown-toggle" type="button" data-bs-toggle="dropdown">

                    Sắp xếp

                </button>

                <ul class="dropdown-menu">

                    <li>
                        <h6 class="dropdown-header">
                            Tổng tiền </h6>
                    </li>

                    <li>
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/import?sort=totalAsc">

                            Thấp → Cao

                        </a>
                    </li>

                    <li>
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/import?sort=totalDesc">

                            Cao → Thấp

                        </a>
                    </li>

                </ul>

            </div>

            <% } else { %>

            <span class="text-muted">
        Chỉ xem
    </span>

            <% } %>

        </div>

    </div>

    <!-- ================= TABLE ================= -->

    <div class="card shadow-sm">

        <div class="card-header bg-white">

            <strong> Danh sách phiếu nhập </strong>

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
                            Mã phiếu
                        </th>

                        <th>
                            Ngày nhập
                        </th>

                        <th>
                            Nhà cung cấp
                        </th>

                        <th>
                            Người nhập
                        </th>

                        <th>
                            Tổng tiền
                        </th>

                        <th class="text-center">
                            Thao tác
                        </th>

                    </tr>

                    </thead>

                    <tbody>

                    <%if (receipts != null &&
                            !receipts.isEmpty()) {

                        int stt = 1;

                        for (ImportReceipt receipt : receipts) {

                            ImportReceiptDetail receiptDetail = null;

                            if (details != null) {

                                for (ImportReceiptDetail detail : details) {

                                    if (detail.getReceipt() != null
                                            && detail.getReceipt()
                                            .getReceiptId()
                                            .equals(receipt.getReceiptId())) {

                                        receiptDetail = detail;
                                        break;
                                    }
                                }
                            }%>

                    <tr>

                        <!-- STT -->

                        <td class="text-center">

                            <%= stt++ %>

                        </td>

                        <!-- MÃ PHIẾU -->

                        <td>

                            <strong> #<%= receipt.getReceiptId() %>
                            </strong>

                        </td>

                        <!-- NGÀY NHẬP -->

                        <td>

                            <%if (receipt.getImportDate() != null) {%>

                            <%= dateFormat.format(
                                    receipt.getImportDate()
                            ) %>

                            <%} else {%>

                            -

                            <%}%>

                        </td>

                        <!-- NHÀ CUNG CẤP -->

                        <td>

                            <%if (receipt.getSupplier() != null) {%>

                            <%= receipt.getSupplier().getSupplierName() %>

                            <%} else {%>

                            -

                            <%}%>

                        </td>

                        <!-- NGƯỜI NHẬP -->

                        <td>

                            <%if (receipt.getUser() != null) {%>

                            <%= receipt.getUser().getFullName() %>

                            <%} else {%>

                            -

                            <%}%>

                        </td>

                        <!-- TỔNG TIỀN -->

                        <td>

                            <strong>

                                <%= String.format(
                                        "%,.0f",
                                        receipt.getTotalAmount() != null
                                                ? receipt.getTotalAmount()
                                                : 0.0
                                ) %> đ

                            </strong>

                        </td>

                        <!-- THAO TÁC -->

                        <td class="text-center">

                            <!-- MANAGER + EMPLOYEE ĐƯỢC SỬA -->

                            <% if ("Manager".equals(currentUser.getRole())
                                    || "Employee".equals(currentUser.getRole())) { %>

                            <button type="button" class="btn btn-outline-light text-dark" data-bs-toggle="modal"
                                    data-bs-target="#editReceiptModal<%= receipt.getReceiptId() %>">

                                Sửa

                            </button>

                            <% } %>

                            <!-- CHỈ MANAGER ĐƯỢC XÓA -->

                            <% if ("Manager".equals(currentUser.getRole())) { %>

                            <form method="post" action="<%= request.getContextPath() %>/import" style="display:inline;">

                                <input type="hidden" name="action" value="delete">

                                <input type="hidden" name="receiptId" value="<%= receipt.getReceiptId() %>">

                                <button type="submit" class="btn btn-outline-light text-dark"
                                        onclick="return confirm('Bạn có chắc muốn xóa phiếu nhập này không?');">

                                    Xóa

                                </button>

                            </form>

                            <% } %>

                            <% if (!"Manager".equals(currentUser.getRole())
                                    && !"Employee".equals(currentUser.getRole())) { %>

                            <span class="text-muted">

                                Chỉ xem

                            </span>

                            <% } %>

                        </td>

                    </tr>

                    <!-- ================= EDIT MODAL ================= -->

                    <% if (("Manager".equals(currentUser.getRole())
                            || "Employee".equals(currentUser.getRole()))
                            && receiptDetail != null) { %>

                    <div class="modal fade" id="editReceiptModal<%= receipt.getReceiptId() %>" tabindex="-1">

                        <div class="modal-dialog">

                            <div class="modal-content">

                                <div class="modal-header">

                                    <h5 class="modal-title">

                                        Sửa phiếu nhập

                                    </h5>

                                    <button type="button" class="btn-close" data-bs-dismiss="modal">

                                    </button>

                                </div>

                                <form method="post" action="<%= request.getContextPath() %>/import">

                                    <div class="modal-body">

                                        <input type="hidden" name="action" value="update">

                                        <input type="hidden" name="receiptId" value="<%= receipt.getReceiptId() %>">

                                        <input type="hidden" name="detailId" value="<%= receiptDetail.getDetailId() %>">

                                        <!-- NHÀ CUNG CẤP -->

                                        <div class="mb-3">

                                            <label class="form-label">

                                                Nhà cung cấp

                                            </label>

                                            <select name="supplierId" class="form-select" required>

                                                <%if (suppliers != null) {

                                                    for (Supplier supplier : suppliers) {%>

                                                <option value="<%= supplier.getSupplierId() %>"

                                                        <%= receipt.getSupplier() != null &&
                                                                receipt.getSupplier()
                                                                        .getSupplierId()
                                                                        .equals(supplier.getSupplierId())
                                                                ? "selected"
                                                                : "" %>>

                                                    <%= supplier.getSupplierName() %>

                                                </option>

                                                <%}

                                                }%>

                                            </select>

                                        </div>

                                        <!-- SẢN PHẨM -->

                                        <div class="mb-3">

                                            <label class="form-label">

                                                Sản phẩm

                                            </label>

                                            <input type="text" class="form-control" value="<%= receiptDetail.getProduct() != null
                                                           ? receiptDetail.getProduct().getProductName()
                                                           : "" %>" readonly>

                                        </div>

                                        <!-- SỐ LƯỢNG -->

                                        <div class="mb-3">

                                            <label class="form-label">

                                                Số lượng

                                            </label>

                                            <input type="number" name="quantity" class="form-control"
                                                   value="<%= receiptDetail.getQuantity() %>" min="1" required>

                                        </div>

                                        <!-- ĐƠN GIÁ -->

                                        <!-- ĐƠN GIÁ -->

                                        <div class="mb-3">

                                            <label class="form-label"> Đơn giá </label>

                                            <input type="text" class="form-control" value="<%= receiptDetail.getProduct() != null
                   ? String.format("%,.0f",
                       receiptDetail.getProduct().getImportPrice())
                   : "0" %>" readonly>

                                            <!-- Giá thật gửi về Servlet -->
                                            <input type="hidden" name="unitPrice" value="<%= receiptDetail.getProduct() != null
                   ? receiptDetail.getProduct().getImportPrice()
                   : 0 %>">

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

                    <!-- KHÔNG CÓ DỮ LIỆU -->

                    <tr>

                        <td colspan="7" class="text-center
                                   text-muted
                                   py-4">

                            Chưa có phiếu nhập nào.

                        </td>

                    </tr>

                    <%}%>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<!-- ================= ADD MODAL ================= -->

<% if ("Manager".equals(currentUser.getRole())
        || "Employee".equals(currentUser.getRole())) { %>

<div class="modal fade" id="addReceiptModal" tabindex="-1">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title">

                    Thêm phiếu nhập

                </h5>

                <button type="button" class="btn-close" data-bs-dismiss="modal">

                </button>

            </div>

            <form method="post" action="<%= request.getContextPath() %>/import">

                <div class="modal-body">

                    <input type="hidden" name="action" value="create">

                    <!-- NHÀ CUNG CẤP -->

                    <div class="mb-3">

                        <label class="form-label"> Nhà cung cấp </label>

                        <select name="supplierId" class="form-select" required>

                            <option value="">
                                -- Chọn nhà cung cấp --
                            </option>

                            <%if (suppliers != null) {
                                for (Supplier supplier : suppliers) {%>

                            <option value="<%= supplier.getSupplierId() %>">
                                <%= supplier.getSupplierName() %>
                            </option>

                            <%}
                            }%>

                        </select>

                    </div>

                    <!-- SẢN PHẨM -->

                    <div class="mb-3">

                        <label class="form-label"> Sản phẩm </label>

                        <select name="productId" id="productId" class="form-select" required
                                onchange="updateImportPrice()">

                            <option value="">
                                -- Chọn sản phẩm --
                            </option>

                            <%if (products != null) {
                                for (Product product : products) {%>

                            <option value="<%= product.getProductId() %>" data-price="<%= product.getImportPrice() %>">

                                <%= product.getProductName() %>

                            </option>

                            <%}
                            }%>

                        </select>

                    </div>

                    <div class="row">

                        <!-- SỐ LƯỢNG -->

                        <div class="col-md-6 mb-3">

                            <label class="form-label"> Số lượng </label>

                            <input type="number" name="quantity" id="quantity" class="form-control" min="1" value="1"
                                   required onchange="calculateTotal()">

                        </div>

                        <!-- ĐƠN GIÁ -->

                        <div class="col-md-6 mb-3">

                            <label class="form-label"> Đơn giá </label>

                            <input type="number" name="unitPrice" id="unitPrice" class="form-control" readonly required>

                        </div>

                    </div>

                    <!-- TỔNG TIỀN -->

                    <div class="mb-3">

                        <label class="form-label"> Tổng tiền </label>

                        <input type="text" id="totalDisplay" class="form-control" readonly>

                    </div>

                </div>

                <div class="modal-footer">

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">

                        Hủy

                    </button>

                    <button type="submit" class="btn btn-primary">

                        Thêm phiếu nhập

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

<% } %>

<!-- ================= BOOTSTRAP ================= -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>