<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .header-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .header-section h2 {
            margin: 0;
            font-weight: 600;
        }

        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-left: 4px solid #667eea;
        }

        .stats-card h3 {
            font-size: 32px;
            font-weight: bold;
            margin: 0;
            color: #667eea;
        }

        .stats-card p {
            margin: 0;
            color: #6c757d;
            font-size: 14px;
        }

        .search-box {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .search-input {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 12px 20px;
            padding-left: 45px;
        }

        .search-input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
        }

        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .btn-add {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .table-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: #f8f9fa;
            color: #495057;
            font-weight: 600;
            border: none;
            padding: 15px;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }

        .table tbody td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #f0f0f0;
        }

        .table tbody tr:hover {
            background: #f8f9ff;
        }

        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 10px;
            border: 2px solid #e9ecef;
        }

        .product-images-container {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }

        .product-img-item {
            position: relative;
            width: 60px;
            height: 60px;
        }

        .product-img-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 10px;
            border: 2px solid #e9ecef;
            transition: all 0.2s;
        }

        .product-img-item:hover img {
            border-color: #667eea;
            transform: scale(1.05);
        }

        .product-img-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #667eea;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
            font-weight: bold;
            border: 2px solid white;
        }

        .more-images {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            border: 2px dashed #adb5bd;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8f9fa;
            color: #6c757d;
            font-size: 12px;
            font-weight: 600;
        }

        .product-name {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .product-category {
            font-size: 12px;
            color: #6c757d;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .price-original {
            font-size: 14px;
            color: #495057;
            font-weight: 600;
        }

        .price-sale {
            font-size: 16px;
            color: #dc3545;
            font-weight: 700;
        }

        .price-old {
            font-size: 12px;
            color: #adb5bd;
            text-decoration: line-through;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 11px;
        }

        .badge-success {
            background: #d4edda;
            color: #155724;
        }

        .badge-danger {
            background: #f8d7da;
            color: #721c24;
        }

        .badge-warning {
            background: #fff3cd;
            color: #856404;
        }

        .badge-sale {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            font-size: 10px;
            padding: 4px 8px;
            margin-left: 8px;
        }

        .stock-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-action {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
            margin: 0 3px;
        }

        .btn-edit {
            background: #e3f2fd;
            color: #1976d2;
        }

        .btn-edit:hover {
            background: #1976d2;
            color: white;
            transform: translateY(-2px);
        }

        .btn-delete {
            background: #ffebee;
            color: #c62828;
        }

        .btn-delete:hover {
            background: #c62828;
            color: white;
            transform: translateY(-2px);
        }

        .btn-view {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        .btn-view:hover {
            background: #7b1fa2;
            color: white;
            transform: translateY(-2px);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-state i {
            font-size: 80px;
            color: #dee2e6;
            margin-bottom: 20px;
        }

        .empty-state h4 {
            color: #6c757d;
            margin-bottom: 10px;
        }

        .pagination {
            margin-top: 20px;
            justify-content: center;
        }

        .pagination .page-link {
            border: none;
            color: #667eea;
            padding: 10px 15px;
            margin: 0 3px;
            border-radius: 8px;
        }

        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .filter-badge {
            display: inline-block;
            padding: 8px 15px;
            background: #e9ecef;
            border-radius: 20px;
            margin-right: 10px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-badge:hover, .filter-badge.active {
            background: #667eea;
            color: white;
        }
    </style>
</head>
<body>
<!-- Header Section -->
<div class="header-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h2><i class="bi bi-box-seam me-2"></i>Quản Lý Sản Phẩm</h2>
            </div>
            <div class="col-md-6 text-end">
                <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-add">
                    <i class="bi bi-plus-circle me-2"></i>Thêm Sản Phẩm
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="stats-card">
                <h3>${products.size()}</h3>
                <p><i class="bi bi-box"></i> Tổng sản phẩm</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card" style="border-left-color: #28a745;">
                <h3 style="color: #28a745;">
                    <c:set var="activeCount" value="0"/>
                    <c:forEach var="p" items="${products}">
                        <c:if test="${p.active}">
                            <c:set var="activeCount" value="${activeCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${activeCount}
                </h3>
                <p><i class="bi bi-check-circle"></i> Đang kinh doanh</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card" style="border-left-color: #dc3545;">
                <h3 style="color: #dc3545;">
                    <c:set var="outOfStock" value="0"/>
                    <c:forEach var="p" items="${products}">
                        <c:if test="${p.quantity == 0}">
                            <c:set var="outOfStock" value="${outOfStock + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${outOfStock}
                </h3>
                <p><i class="bi bi-exclamation-circle"></i> Hết hàng</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card" style="border-left-color: #ffc107;">
                <h3 style="color: #ffc107;">
                    <c:set var="onSale" value="0"/>
                    <c:forEach var="p" items="${products}">
                        <c:if test="${p.salePrice != null && p.salePrice < p.price}">
                            <c:set var="onSale" value="${onSale + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${onSale}
                </h3>
                <p><i class="bi bi-tag"></i> Đang giảm giá</p>
            </div>
        </div>
    </div>

    <!-- Search Box -->
    <div class="search-box">
        <div class="row align-items-center">
            <div class="col-md-8">
                <form action="${pageContext.request.contextPath}/admin/product/search" method="get">
                    <div class="position-relative">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text"
                               class="form-control search-input"
                               name="keyword"
                               placeholder="Tìm kiếm theo tên sản phẩm hoặc mô tả..."
                               value="${keyword}">
                    </div>
                </form>
            </div>
            <div class="col-md-4 text-end">
                <div class="filter-badge active">
                    <i class="bi bi-grid-3x3"></i> Tất cả
                </div>
                <div class="filter-badge">
                    <i class="bi bi-tag"></i> Khuyến mãi
                </div>
            </div>
        </div>
    </div>

    <!-- Products Table -->
    <div class="table-card">
        <c:if test="${not empty products}">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th style="width: 5%;">ID</th>
                        <th style="width: 10%;">Hình ảnh</th>
                        <th style="width: 25%;">Tên sản phẩm</th>
                        <th style="width: 15%;">Giá</th>
                        <th style="width: 10%;">Số lượng</th>
                        <th style="width: 10%;">Trạng thái</th>
                        <th style="width: 15%;" class="text-center">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td><strong>#${product.productId}</strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty product.image}">
                                        <c:set var="imageArray" value="${fn:split(product.image, ';')}"/>
                                        <div class="product-images-container">
                                            <c:choose>
                                                <c:when test="${fn:length(imageArray) == 1}">
                                                    <!-- Hiển thị 1 ảnh -->
                                                    <div class="product-img-item">
                                                        <c:url value="/image?fname=${imageArray[0]}" var="imgUrl"></c:url>
                                                        <img src="${imgUrl}"
                                                             alt="${product.productName}"
                                                             data-bs-toggle="modal"
                                                             data-bs-target="#imageModal${product.productId}"
                                                             style="cursor: pointer;">
                                                    </div>
                                                </c:when>
                                                <c:when test="${fn:length(imageArray) <= 2}">
                                                    <!-- Hiển thị 2 ảnh -->
                                                    <c:forEach var="img" items="${imageArray}" varStatus="status">
                                                        <div class="product-img-item">
                                                            <c:url value="/image?fname=${img}" var="imgUrl"></c:url>
                                                            <img src="${imgUrl}"
                                                                 alt="${product.productName}"
                                                                 data-bs-toggle="modal"
                                                                 data-bs-target="#imageModal${product.productId}"
                                                                 style="cursor: pointer;">
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Hiển thị 2 ảnh đầu + số lượng còn lại -->
                                                    <c:forEach var="img" items="${imageArray}" varStatus="status" begin="0" end="1">
                                                        <div class="product-img-item">
                                                            <c:url value="/image?fname=${img}" var="imgUrl"></c:url>
                                                            <img src="${imgUrl}"
                                                                 alt="${product.productName}"
                                                                 data-bs-toggle="modal"
                                                                 data-bs-target="#imageModal${product.productId}"
                                                                 style="cursor: pointer;">
                                                            <c:if test="${status.index == 0}">
                                                                <span class="product-img-badge">${fn:length(imageArray)}</span>
                                                            </c:if>
                                                        </div>
                                                    </c:forEach>
                                                    <div class="more-images"
                                                         data-bs-toggle="modal"
                                                         data-bs-target="#imageModal${product.productId}"
                                                         style="cursor: pointer;">
                                                        +${fn:length(imageArray) - 2}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <!-- Modal xem tất cả ảnh -->
                                        <div class="modal fade" id="imageModal${product.productId}" tabindex="-1">
                                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                                <div class="modal-content" style="border-radius: 15px; border: none;">
                                                    <div class="modal-header" style="border: none;">
                                                        <h5 class="modal-title">
                                                            <i class="bi bi-images me-2"></i>
                                                                ${product.productName}
                                                        </h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div id="carousel${product.productId}" class="carousel slide" data-bs-ride="carousel">
                                                            <div class="carousel-indicators">
                                                                <c:forEach var="img" items="${imageArray}" varStatus="status">
                                                                    <button type="button"
                                                                            data-bs-target="#carousel${product.productId}"
                                                                            data-bs-slide-to="${status.index}"
                                                                            class="${status.index == 0 ? 'active' : ''}"
                                                                            aria-current="${status.index == 0 ? 'true' : 'false'}"></button>
                                                                </c:forEach>
                                                            </div>
                                                            <div class="carousel-inner">
                                                                <c:forEach var="img" items="${imageArray}" varStatus="status">
                                                                    <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                                                        <c:url value="/image?fname=${img}" var="imgUrl"></c:url>
                                                                        <img src="${imgUrl}"
                                                                             class="d-block w-100"
                                                                             style="border-radius: 10px; max-height: 500px; object-fit: contain;"
                                                                             alt="Image ${status.index + 1}">
                                                                        <div class="carousel-caption">
                                                                                    <span class="badge bg-dark">
                                                                                        ${status.index + 1} / ${fn:length(imageArray)}
                                                                                    </span>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                            <button class="carousel-control-prev" type="button" data-bs-target="#carousel${product.productId}" data-bs-slide="prev">
                                                                <span class="carousel-control-prev-icon"></span>
                                                            </button>
                                                            <button class="carousel-control-next" type="button" data-bs-target="#carousel${product.productId}" data-bs-slide="next">
                                                                <span class="carousel-control-next-icon"></span>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-img-item">
                                            <div class="d-flex align-items-center justify-content-center"
                                                 style="width: 60px; height: 60px; background: #f0f0f0; border-radius: 10px;">
                                                <i class="bi bi-image" style="font-size: 24px; color: #adb5bd;"></i>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="product-name">${product.productName}</div>
                                <div class="product-category">
                                    <i class="bi bi-tag"></i>
                                    <c:choose>
                                        <c:when test="${not empty product.category}">
                                            ${product.category.catename}
                                        </c:when>
                                        <c:otherwise>
                                            Chưa phân loại
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.salePrice != null && product.salePrice < product.price}">
                                        <div class="price-sale">
                                            <fmt:formatNumber value="${product.salePrice}" type="number" groupingUsed="true"/>đ
                                            <span class="badge badge-sale">
                                                        <i class="bi bi-lightning-fill"></i> SALE
                                                    </span>
                                        </div>
                                        <div class="price-old">
                                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="price-original">
                                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                        <span class="stock-badge">
                                            <c:choose>
                                                <c:when test="${product.quantity == 0}">
                                                    <span class="badge badge-danger">
                                                        <i class="bi bi-x-circle"></i> Hết hàng
                                                    </span>
                                                </c:when>
                                                <c:when test="${product.quantity < 10}">
                                                    <span class="badge badge-warning">
                                                        <i class="bi bi-exclamation-triangle"></i> ${product.quantity}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-success">
                                                        <i class="bi bi-check-circle"></i> ${product.quantity}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.active}">
                                                <span class="badge badge-success">
                                                    <i class="bi bi-check-circle"></i> Hoạt động
                                                </span>
                                    </c:when>
                                    <c:otherwise>
                                                <span class="badge badge-danger">
                                                    <i class="bi bi-x-circle"></i> Tạm dừng
                                                </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/product/view?id=${product.productId}"
                                   class="btn-action btn-view"
                                   title="Xem chi tiết">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/product/edit?id=${product.productId}"
                                   class="btn-action btn-edit"
                                   title="Chỉnh sửa">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <button class="btn-action btn-delete"
                                        onclick="confirmDelete(${product.productId})"
                                        title="Xóa">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <c:if test="${empty products}">
            <div class="empty-state">
                <i class="bi bi-inbox"></i>
                <h4>Chưa có sản phẩm nào</h4>
                <p class="text-muted">Hãy thêm sản phẩm đầu tiên của bạn</p>
                <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-add mt-3">
                    <i class="bi bi-plus-circle me-2"></i>Thêm Sản Phẩm Ngay
                </a>
            </div>
        </c:if>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 15px; border: none;">
            <div class="modal-header" style="border: none; padding: 25px 25px 15px;">
                <h5 class="modal-title">
                    <i class="bi bi-exclamation-triangle text-danger me-2"></i>
                    Xác nhận xóa
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" style="padding: 15px 25px 25px;">
                <p>Bạn có chắc chắn muốn xóa sản phẩm này không? Hành động này không thể hoàn tác!</p>
            </div>
            <div class="modal-footer" style="border: none; padding: 0 25px 25px;">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                    <i class="bi bi-trash me-2"></i>Xóa
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(productId) {
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        const confirmBtn = document.getElementById('confirmDeleteBtn');
        confirmBtn.href = '${pageContext.request.contextPath}/admin/product/delete?id=' + productId;
        deleteModal.show();
    }

    // Auto hide alerts
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        });
    }, 3000);
</script>
</body>
</html>